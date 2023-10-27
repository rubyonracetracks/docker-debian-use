#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

# Parameters 1 and 2: 1st guest port number and corresponding host port number
# Parameters 3 and 4: 2nd guest port number and corresponding host port number
# Parameters 5 and 6: 3rd . . . .
# Parameters 11 and 12: . . . .

############################################
# BEGIN: setting environment variable inputs
############################################

ARRAY_PORTS=() # NOTE: Always has an even number of elements
i=0
while [ $# -gt 1 ]; do # If the number of port numbers is odd, the last one is ignored.
  # ARRAY_PORTS+=($1 $2)
  ARRAY_PORTS[i]=$1
  ARRAY_PORTS[i+1]=$2
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  i=$((i+2))
done

# echo "All elements of ARRAY_PORTS: ${ARRAY_PORTS[@]}"
# echo "Number of elements in ARRAY_PORTS: ${#ARRAY_PORTS[@]}"

###############################################
# FINISHED: setting environment variable inputs
###############################################

# Reading the variable values from the parameter files
ABBREV=`cat tmp/ABBREV.txt`
SUITE=`cat tmp/SUITE.txt`
OWNER=`cat tmp/OWNER.txt`
DISTRO=`cat tmp/DISTRO.txt`

# Creating the necessary directories
WORK_DIR="tmp/$ABBREV/$SUITE"
WORK_SHARED="$WORK_DIR/shared"
mkdir -p $WORK_DIR
mkdir -p $WORK_SHARED

##########################
# BEGIN: copying use files
##########################

# Copy files for using Docker image/container
cp templates_use/* $WORK_DIR

#############################
# FINISHED: copying use files
#############################

#############################
# BEGIN: copying shared files
#############################

cp templates_shared/info.sh $WORK_DIR/shared # For all Docker images
cp templates_shared/README-host.txt $WORK_SHARED # For all Docker images

copy_all_but_stage1 () {
  cp templates_shared/README-postgres.txt $WORK_SHARED
  cp templates_shared/pg-reset.sh $WORK_SHARED
  cp templates_shared/pg-setup.sh $WORK_SHARED
}

copy_rails_only () {
  cp templates_shared/test-rails-sq.sh $WORK_SHARED
  cp templates_shared/test-rails-pg.sh $WORK_SHARED
}

# For all images other than min-stage1
grep_stage1=`echo $ABBREV | grep min-stage1`
if [[ "$grep_stage1" == '' ]]
then
  copy_all_but_stage1
fi

# For Rails images only
if [[ "$ABBREV" =~ 'rails' ]]
then
  copy_rails_only
fi

if [[ "$ABBREV" =~ 'react' ]]
then
  cp templates_shared/test-react.sh $ABBREV/shared
  cp templates_shared/create-react-static.sh $ABBREV/shared
fi

if [[ "$ABBREV" =~ 'docusaurus' ]]
then
  cp templates_shared/test-docusaurus.sh $ABBREV/shared
  cp templates_shared/create-docusaurus.sh $ABBREV/shared
fi

################################
# FINISHED: copying shared files
################################

########################################################
# BEGIN: filling in the Docker image and container names
########################################################

# Fill in DOCKER_IMAGE and CONTAINER parameters
fill_in_params () {
  FILE_TO_UPDATE=$1
  # NOTE: Using | as delimiter in sed command
  sed -i.bak "s|<ABBREV>|$ABBREV|g" $FILE_TO_UPDATE
  sed -i.bak "s|<SUITE>|$SUITE|g" $FILE_TO_UPDATE
  sed -i.bak "s|<OWNER>|$OWNER|g" $FILE_TO_UPDATE
  sed -i.bak "s|<DISTRO>|$DISTRO|g" $FILE_TO_UPDATE
  sed -i.bak "s|<DOCKER_IMAGE>|$DOCKER_IMAGE|g" $FILE_TO_UPDATE
  sed -i.bak "s|<CONTAINER>|$CONTAINER|g" $FILE_TO_UPDATE
  rm $FILE_TO_UPDATE.bak
}

for FILE in `ls $WORK_DIR/*.sh`
do
  fill_in_params $FILE
done

# Provide Docker image and container names when running the info.sh script
source $WORK_DIR/variables.sh
echo "DOCKER_IMAGE: $DOCKER_IMAGE"
echo '---------------------------' > $WORK_SHARED/docker.txt
echo "Docker Image: $DOCKER_IMAGE" >> $WORK_SHARED/docker.txt
echo '----------------------------' >> $WORK_SHARED/docker.txt
echo "Docker Container: $CONTAINER" >> $WORK_SHARED/docker.txt
echo '----------------------------' >> $WORK_SHARED/docker.txt

###########################################################
# FINISHED: filling in the Docker image and container names
###########################################################

#########################
# BEGIN: setting up ports
#########################

# Provide port numbers in shared/ports.txt file
# Provide port numbers in container_create.sh
echo '--------------------------------' > $WORK_SHARED/ports.txt
echo 'PORT FORWARDING (Host -> Docker)' >> $WORK_SHARED/ports.txt

i=0
LEN_ARRAY_PORTS=${#ARRAY_PORTS[@]}
INDEX_LAST=$((LEN_ARRAY_PORTS-1))
PORT_STRING=''
while [ $((i+1)) -le $((INDEX_LAST)) ]; do # If the number of port numbers is odd, the last one is ignored.
  P0=${ARRAY_PORTS[i]}
  P1=${ARRAY_PORTS[i+1]}
  PORT_STRING+=" -p $P0:$P1"
  echo "$P0 -> $P1" >> $WORK_SHARED/ports.txt
  i=$((i+2))
done

sed -i.bak "s/#PORT_SPECIFICATIONS_HERE/$PORT_STRING/g" $WORK_DIR/container_create.sh
rm $WORK_DIR/container_create.sh.bak

############################
# FINISHED: setting up ports
############################

echo '***************************************'
echo 'Enter the following command to proceed:'
echo "cd $WORK_DIR"
