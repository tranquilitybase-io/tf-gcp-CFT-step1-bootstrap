PROJECTS_FOLDER=./app-infra
[ -d $PROJECTS_FOLDER ] && { echo "Removing past deployment file $PROJECTS_FOLDER"; rm -rf $PROJECTS_FOLDER; } || echo "No past deployments found"

echo sourcing required variables
source ./scripts/5-app-infra/env-variables.sh

echo Creating app-infra folder
mkdir app-infra
cd ./app-infra

echo Cloning CFT
CFT_FOLDER=./terraform-example-foundation
[ -d $CFT_FOLDER ] && { echo "Removing past deployment file: $CFT_FOLDER"; rm -rf $CFT_FOLDER; } || echo "No past deployments found"
git clone https://github.com/terraform-google-modules/terraform-example-foundation.git



echo Checkout latest release
cd ./terraform-example-foundation/
git checkout ed164ba
cd ..

echo Cloning gcp gcp-policies GSR
GCP_POLICIES_FOLDER=./gcp-policies
[ -d $GCP_POLICIES_FOLDER ] && { echo "Removing past deployment file: $GCP_POLICIES_FOLDER"; rm -rf $GCP_POLICIES_FOLDER; } || echo "No past deployments found"
gcloud source repos clone gcp-policies --project=$YOUR_INFRA_PIPELINE_PROJECT_ID


cd gcp-policies


echo Copy review policies
cp -R ../terraform-example-foundation/policy-library/ .

echo commit changes
git add .
git commit -m 'Your message'

echo set and push to master
git push --set-upstream origin master --force
cd ..

echo Cloning gcp bu1-example-app GSR
GCP_APP_INFRA_FOLDER=./bu1-example-app
[ -d $GCP_APP_INFRA_FOLDER ] && { echo "Removing past deployment file: $GCP_APP_INFRA_FOLDER"; rm -rf $GCP_APP_INFRA_FOLDER; } || echo "No past deployments found"
gcloud source repos clone bu1-example-app --project=$YOUR_INFRA_PIPELINE_PROJECT_ID
cd bu1-example-app

echo Checkout bu1 example app
git checkout -b plan

echo Copy in needed files
cp -R ../terraform-example-foundation/5-app-infra/ .
cp ../terraform-example-foundation/build/cloudbuild-tf-* .
cp ../terraform-example-foundation/build/tf-wrapper.sh .
chmod 755 ./tf-wrapper.sh



echo Removing unneeded bu1-development.auto.example.tfvars
TF_EXAMPLE_VARS=./bu1-development.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; }

echo Copying in needed bu1-development.auto.tfvars
TF_VARS=../../scripts/5-app-infra/bu1-development.auto.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found";  }

echo Removing unneeded bu1-non-production.auto.example.tfvars
TF_EXAMPLE_VARS=./bu1-non-production.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; }

echo Copying in needed bu1-non-production.auto.tfvars
TF_VARS=../../scripts/5-app-infra/bu1-non-production.auto.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found";  }

echo Removing unneeded bu1-production.auto.example.tfvars
TF_EXAMPLE_VARS=./bu1-production.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; }

echo Copying in needed bu1-production.auto.example.tfvars
TF_VARS=../../scripts/5-app-infra/bu1-production.auto.example.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found";  }

echo Removing unneeded common.auto.example.tfvars
TF_EXAMPLE_VARS=./common.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; }

echo Copying in needed common.auto.tfvars
TF_VARS=../../scripts/5-app-infra/common.auto.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found";  }


git add .
git commit -m 'Your message'
git push --set-upstream origin plan --force

sleep 300

git checkout -b development
git push origin development --force

sleep 300

git checkout -b non-production
git push origin non-production --force

sleep 300

git checkout -b production
git push origin production --force
