#!/bin/bash

( \
  START_DATE=$(date +"%Y-%m-01"); \
  END_DATE=$(date +"%Y-%m-01" -d "$DATE + 1 month"); \
aws ce get-cost-and-usage \
--time-period "Start=$START_DATE,End=$END_DATE" \
--metrics 'UnblendedCost' \
--granularity 'MONTHLY' \
--query 'ResultsByTime[*].Total.[UnblendedCost]' \
--output 'table' \
)

( \
aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,PublicDNS:PublicDNSName,PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}"  \
--filters "Name=instance-state-name,Values=running"  \
--output 'table' \
)

( \
aws s3api list-buckets \
--query "Buckets[].Name" \
--output 'table' \
)

( \
aws dynamodb list-tables \
--output 'table' \
)

( \
aws mq list-brokers \
--query "BrokerSummaries[*].{ID:BrokerId,Name:BrokerName,Mode:DeploymentMode, InstanceType:HostInstanceType, State:BrokerState}" \
--output 'table' \
)

(\
aws rds describe-db-clusters \
--query "DBClusters[*].{AZ:AvailabilityZones,DatabaseName:DatabaseName, Engine:Engine, Version:EngineVersion, ClusterState:DBClusterMembers, State:DBInstanceStatus, Address:Endpoint}" \
--output 'table' \
)


( \
aws rds describe-db-instances \
--query "DBInstances[*].{Type:DBInstanceClass, Identifier:DBInstanceIdentifier, Cluster:DBClusterIdentifier, Engine:Engine, State:DBInstanceStatus, Address:Endpoint.Address}" \
--output 'table' \
)
