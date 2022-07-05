#!/bin/bash
aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicDNS:PublicDNSName,PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}"  \
--filters "Name=instance-state-name,Values=running"  \
--output table

aws rds describe-db-instances \
--query "DBInstances[*].DBInstanceStatus[*]"  \
--filters "Name=instance-state-name,Values=running"  \
--output table
