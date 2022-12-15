#!/usr/bin/env bash

# Deploys services to ECS

set -euo pipefail
if [[ ! -z ${VERBOSE+x} ]]; then
  set -x
fi
if [ "$#" -ne 4 ]; then
  echo "Usage: deploy-ecs <env> <aws-region> <service-name> <tag>"
  exit 1
fi

# Set vars
ENV="$1"
AWS="aws --region $2 --output json"
SERVICE_NAME="$3"
TAG="$4"
ENV_SERVICE_NAME="$ENV-$SERVICE_NAME"
ECR_URI=$($AWS ecr describe-repositories | \
  jq --arg SERVICE_NAME "$SERVICE_NAME" -r '.repositories | map(select(.repositoryName == $SERVICE_NAME)) | .[0].repositoryUri')

# tag it with the ENV because that is what's referenced in the task definition
# tag it with the sha tag for a record in ECR
docker tag $SERVICE_NAME:$TAG $ECR_URI:$ENV
docker tag $SERVICE_NAME:$TAG $ECR_URI:$TAG
docker push $ECR_URI:$ENV
docker push $ECR_URI:$TAG

$AWS ecs update-service --cluster ${ECS_CLUSTER_NAME:-common-cluster} --service $ENV_SERVICE_NAME --force-new-deployment
