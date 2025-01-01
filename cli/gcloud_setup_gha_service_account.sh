SA_NAME="github-actions-deployer"
SA_DESCRIPTION="Service account used by GitHub Actions to deploy the Speech2Text application to Google Cloud Run."
IAM_ACCOUNT="$SA_NAME@$GCP_PROJECT_ID.iam.gserviceaccount.com"
# Create service account
gcloud iam service-accounts create $SA_NAME \
  --project "$GCP_PROJECT_ID" \
  --description "$SA_DESCRIPTION" \
  --display-name "$SA_NAME"

# Allow pushing to container registry
gcloud projects add-iam-policy-binding "$GCP_PROJECT_ID" \
  --member="serviceAccount:$IAM_ACCOUNT" \
  --role="roles/storage.admin"

# Allow deploying to Google Cloud Run
gcloud projects add-iam-policy-binding "$GCP_PROJECT_ID" \
  --member="serviceAccount:$IAM_ACCOUNT" \
  --role="roles/run.admin"

# Allow service account to act as itself
gcloud projects add-iam-policy-binding "$GCP_PROJECT_ID" \
  --member="serviceAccount:$IAM_ACCOUNT" \
  --role="roles/iam.serviceAccountUser"

# Create and download JSON key file used in GHA
gcloud iam service-accounts keys create key.json \
  --project="$GCP_PROJECT_ID" \
  --iam-account=$IAM_ACCOUNT

# Check setup
gcloud iam service-accounts describe $IAM_ACCOUNT \
  --project="$GCP_PROJECT_ID"