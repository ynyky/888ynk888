#!/usr/bin/python3
import boto3
import sys

env_name = sys.argv[1]

BUCKET = f"{env_name}"
print(BUCKET)
s3 = boto3.resource('s3')
bucket = s3.Bucket(BUCKET)
bucket.object_versions.delete()
print(f"deleted-{BUCKET}")
