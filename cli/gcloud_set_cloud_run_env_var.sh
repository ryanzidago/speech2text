POSTGRES_PASSWORD=WGA46Hfe+nWjcqwdNsmjH7ZvkSxeyyvIckf0b4z3j1Q=
POSTGRES_IP_ADDR=34.105.205.214
DATABASE_URL=postgresql://postgres:$POSTGRES_PASSWORD@$POSTGRES_IP_ADDR:5432/speech2text-prod
DOCKER_IMAGE=europe-west2-docker.pkg.dev/speech2text-446412/speech2text/speech2text:bead40c5a96cc66248d7af68245ecf32a25e1c24
SECRET_KEY_BASE=N21WObQO36a+Fys4kkUrldISGShIoXSNhwvYf0vo/LEM7g6oV/NiTLKRynnAH4aQ

# set env var
gcloud run deploy speech2text \
  --image=$DOCKER_IMAGE \
  --set-env-vars=DATABASE_URL=$DATABASE_URL,SECRET_KEY_BASE=$SECRET_KEY_BASE \
  --region=europe-west2