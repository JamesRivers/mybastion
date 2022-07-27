#!/bin/bash

aws s3api list-buckets
read -p "S3 bucket to empty: " bucket
aws s3 rm s3://${bucket} --recursive
