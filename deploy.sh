#!/usr/bin/env bash

GAE_PROJECT=aspektcreations
DEPLOY_VERSION=$1

if [ -z "$DEPLOY_VERSION" ]
then
  TAG=`git describe --abbrev=0`
  # GAE doesn't allow periods
  DEPLOY_VERSION=${TAG//.}
fi

# Build it.
echo "Building $DEPLOY_VERSION"
gulp
cp app.yaml dist/app.yaml

echo "Deploying $DEPLOY_VERSION"
gcloud app deploy dist/app.yaml --project $GAE_PROJECT --promote --version $DEPLOY_VERSION