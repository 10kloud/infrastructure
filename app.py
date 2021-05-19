#!/usr/bin/env python3
import os

from aws_cdk import core as cdk


from stacks.vpc import VpcStack

aws_env = cdk.Environment(
    account=os.getenv('CDK_DEFAULT_ACCOUNT'),
    region="eu-west-1"
)

app = cdk.App()

vpc_stack = VpcStack(
    scope=app,
    construct_id="group5-vpc",
    env=aws_env
)

app.synth()
