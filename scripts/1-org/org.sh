ORG_FOLDER=./org
[ -d $ORG_FOLDER ] && { echo "Removing past deployment file $ORG_FOLDER"; rm -rf $ORG_FOLDER; } || echo "No past deployments found"

#echo sourcing required variables
#source ./scripts/1-org/env-variables.sh


echo Creating org folder
mkdir org
cd ./org

echo Cloning CFT
CFT_FOLDER=./terraform-example-foundation
[ -d $CFT_FOLDER ] && { echo "Removing past deployment file: $CFT_FOLDER"; rm -rf $CFT_FOLDER; } || echo "No past deployments found"
git clone https://github.com/terraform-google-modules/terraform-example-foundation.git

echo Checkout latest release
cd ./terraform-example-foundation/
git checkout ed164ba
cd ..


echo Cloning gcp policies GSR
GCP_POLICIES_FOLDER=./gcp-policies
[ -d $GCP_POLICIES_FOLDER ] && { echo "Removing past deployment file: $GCP_POLICIES_FOLDER"; rm -rf $GCP_POLICIES_FOLDER; } || echo "No past deployments found"
gcloud source repos clone gcp-policies --project=$CLOUD_BUILD_PROJECT_ID
cd gcp-policies

echo Copying policy folder to current directory
POLICY_FOLDER=../terraform-example-foundation/policy-library/
[ -d $POLICY_FOLDER ] && { echo "Copying policy folder to current directory."; cp -R $POLICY_FOLDER .; } || { echo "Error: Directory $POLICY_FOLDER does not exist."; exit 1; }

echo Pushing gcp policies to GSR
git add .
git commit -m 'Your message'
git push --set-upstream origin master
cd ..

echo Cloning gcp-org

GCP_ORG_FOLDER=./gcp-org
[ -d $GCP_ORG_FOLDER ] && { echo "found past deployment file gcp-org file, removing"; rm -rf ./gcp-org; } || echo "No past deployment files found"

gcloud source repos clone gcp-org --project=$CLOUD_BUILD_PROJECT_ID
cd gcp-org
git checkout -b plan

echo Copying in org code
ORG_CODE_LOCATION=../terraform-example-foundation/1-org/.
[ -d $ORG_CODE_LOCATION ] && { echo "copying org files"; cp -R $ORG_CODE_LOCATION .; } || { echo "Can't find org files"; exit 1; }

echo Adding build/wrapper files to gcp-org
BUILD_FILES=../terraform-example-foundation/build
CLOUD_BUILD_FILES=../terraform-example-foundation/build/cloudbuild-tf-*
CLOUD_TF_WRAPPER_FILES=../terraform-example-foundation/build/tf-wrapper.sh

[ -d $BUILD_FILES ] && { echo "copying build files"; cp $CLOUD_BUILD_FILES .; cp $CLOUD_TF_WRAPPER_FILES .;  } || { echo "Can't find build files"; exit 1; }


echo Change wrapper permissions
WRAPPER_FILE=./tf-wrapper.sh
[ -f $WRAPPER_FILE ] && { echo "copying org files"; chmod 755 $WRAPPER_FILE; } || { echo "Can't find wrapper file"; exit 1; }


echo Removing unneeded variables
TF_EXAMPLE_VARS=./envs/shared/terraform.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded terraform.example.tfvars file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No terraform.example.tfvars file found"; exit 1; }


echo Copying in needed variables
TF_VARS=../../scripts/1-org/terraform.auto.tfvars.json
COPY_LOCATION=./envs/shared
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; exit 1; }

git add .
git commit -m 'Your message'
git push --set-upstream origin plan --force

sleep 60

git checkout -b production
git push origin production --force

