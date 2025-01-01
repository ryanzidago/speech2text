#!/bin/bash

# Exit on any error
set -e

# Function to check if required env vars are set
check_env_var() {
  if [ -z "${!1}" ]; then
    echo "Error: $1 environment variable is not set"
    echo "Please, set it using: export $1=value"
    exit 1
  fi
}

check_env_var "GCP_PROJECT_ID"

echo "\nInitializing Google Cloud CLI"
echo "Project ID: $GCP_PROJECT_ID"
echo "Region:  ${GCP_REGION:-europe-west2}"

echo "Running gcloud init..."
gcloud init

echo "Setting project to $GCP_PROJECT_ID..."
gcloud config set project "$GCP_PROJECT_ID"

if [ ! -z "$REGION" ]; then
  echo "Setting region to $REGION..."
  gcloud config set compute/region "$REGION"
fi

# Verify our setup
echo -e "\nCurrent Configuration"
echo "Active account:"
gcloud auth list --filter=status:ACTIVE --format="value(account)"

echo -e "Project info:"
gcloud config list project

echo -e "Available components:"
gcloud components list

echo -e "\nSetup complete! You can now use gcloud commands."
echo "For example, try: gcloud projects list"