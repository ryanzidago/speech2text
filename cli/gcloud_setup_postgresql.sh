#!/bin/bash
set -e
# POSTGRES_PASSWORD=$(openssl rand -base64 32)
POSTGRES_PASSWORD=WGA46Hfe+nWjcqwdNsmjH7ZvkSxeyyvIckf0b4z3j1Q=
# # enable API
# echo -e "Enabling SQL admin API ⏱️"
# gcloud services enable sqladmin.googleapis.com
# echo -e "SQL admin API enabled ✅\n"

# # create a PostgreSQL instance
# echo -e "Creating a PostgreSQL instance ⏱️"
# gcloud sql instances create speech2text-db \
#   --database-version=POSTGRES_16 \
#   --tier=db-custom-1-3840 \
#   --region=europe-west2 \
#   --edition=ENTERPRISE
# echo -e "PostgreSQL instance created ✅\n"

# # create a Postgres user
# echo -e "Creating a Postgres user ⏱️"
# gcloud sql users set-password postgres \
#   --instance=speech2text-db \
#   --password=$POSTGRES_PASSWORD
# echo -e "Postgres user created ✅\n"

# # create a Postgres database
# echo -e "Creating a Postgres database ⏱️"
# gcloud sql databases create speech2text-prod \
#   --instance=speech2text-db
# echo -e "Postgres database created ✅\n"

# # get the connection string
# echo -e "Getting the connection string ⏱️"
# gcloud sql instances describe speech2text-db \
#   --format="get(connectionName)"
# echo -e "Connection string retrieved ✅\n"


gcloud sql users set-password postgres \
  --instance=speech2text-db \
  --password=$POSTGRES_PASSWORD