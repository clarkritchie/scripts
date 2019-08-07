#!/usr/bin/env bash
envs=(
    "auth-service"
)

for env in "${envs[@]}"
do
    # get all the environments for the application
    result=$(aws elasticbeanstalk describe-environments --application-name ${env})

    env_names=$(echo $result | jq --raw-output '.Environments[] | "\(.EnvironmentName)"')

    # get the name of the environment
    for env_name in ${env_names}; do
        echo ${env_name}
        env_status=$(aws elasticbeanstalk describe-environment-health --environment-name ${env_name} --attribute-names All)
        echo ${env_status}
    done
done