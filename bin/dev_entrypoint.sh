#!/bin/bash

# Install dependencies
echo "Installing dependencies..."
mix deps.get

# Checking database availability
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "Waiting for database connection..."
  sleep 2
done

if mix ecto.create; then
  echo "Database $PGDATABASE created."
  mix ecto.migrate
else
  echo "Database $PGDATABASE already exists."
  mix ecto.migrate
fi

exec mix phx.server