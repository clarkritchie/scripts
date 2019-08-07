#!/usr/bin/env bash
dbs=(
    "auth-service-prod"
    "mc-file-service-prod-2"
    "mc-ride-service-prod"
    "mc-component-service-prod"
    "firmware-file-service-prod-2"
    "mc-file-service-prod-2"
    "firmware-file-service-prod-2"
    "mc-bike-settings-service-prod"
    "mc-bike-settings-service-read-prod"
    "mc-app-settings-service-prod"
)

for db in "${dbs[@]}"
do
   result=$(aws rds describe-db-instance-automated-backups --db-instance-identifier ${db})
   echo ${result} | jq '.DBInstanceAutomatedBackups[0].DBInstanceArn'
   echo ${result} | jq '.DBInstanceAutomatedBackups[0].RestoreWindow'
done