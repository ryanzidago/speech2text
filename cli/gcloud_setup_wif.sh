export REPO="ryanzidago/speech2text"

# Create Workload Identity Pool
gcloud iam workload-identity-pools create "github-actions" \
  --project="$GCP_PROJECT_ID" \
  --location="global" \
  --display-name="GitHub Actions Pool" \

# Get the Workload Identity Pool ID
export WORKLOAD_IDENTITY_POOL_ID=$(gcloud iam workload-identity-pools describe "github-actions" \
  --project="$GCP_PROJECT_ID" \
  --location="global" \
  --format="value(name)")

# Create Workload Identity Pool Provider
  # --workload-identity-pool-id="$WORKLOAD_IDENTITY_POOL_ID" \
gcloud iam workload-identity-pools providers create-oidc "github-actions" \
  --project="$GCP_PROJECT_ID" \
  --location="global" \
  --workload-identity-pool="github-actions" \
  --display-name="GitHub Actions Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" \
  --attribute-condition="assertion.repository=='ryanzidago/speech2text'" \
  --issuer-uri="https://token.actions.githubusercontent.com"

# # Create service account
SA_NAME="github-actions-deployer"
# SA_DESCRIPTION="Service account used by GitHub Actions to deploy the Speech2Text application to Google Cloud Run."
IAM_ACCOUNT="$SA_NAME@$GCP_PROJECT_ID.iam.gserviceaccount.com"
# # Create service account
# gcloud iam service-accounts create $SA_NAME \
#   --project "$GCP_PROJECT_ID" \
#   --description "$SA_DESCRIPTION" \
#   --display-name "$SA_NAME"

gcloud projects add-iam-policy-binding "${GCP_PROJECT_ID}" \
  --member="serviceAccount:$IAM_ACCOUNT" \
  --role="roles/artifactregistry.writer"

# Allow authentications from the Github Actions workflow to impersonate the service account
gcloud iam service-accounts add-iam-policy-binding "$IAM_ACCOUNT" \
  --project="$GCP_PROJECT_ID" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/$REPO"