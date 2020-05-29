#!/bin/bash

# AWS region array
array=(
"us-east-2"
"us-east-1"
"us-west-1"
"us-west-2"
"af-south-1"
"ap-east-1"
"ap-south-1"
#"ap-northeast-3"
"ap-northeast-2"
"ap-southeast-1"
"ap-southeast-2"
"ap-northeast-1"
"ca-central-1"
#"cn-north-1"
#"cn-northwest-1"
"eu-central-1"
"eu-west-1"
"eu-west-2"
"eu-south-1"
"eu-west-3"
"eu-north-1"
"me-south-1"
"sa-east-1"
"${arr[@]}")

echo "Looking for running EC2 instances"
for region in "${array[@]}"
do
	echo $region
    aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,KeyName,LaunchTime]' --filters Name=instance-state-name,Values=running --output table --region $region
done

echo "Looking for running RDS instances"
for region in "${array[@]}"
do
	echo $region
    #aws rds describe-db-instances --output table --region $region
    aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`available`].[DBInstanceIdentifier,DBInstanceStatus,DBInstanceClass,InstanceCreateTime]' --output table --region $region
done