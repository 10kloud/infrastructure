#!/usr/bin/env python3
import os

from aws_cdk import core as cdk
import yaml

from stacks import VpcStack
from stacks import DataStack


def load_settings():
    with open("settings.yml") as file:
        values = yaml.safe_load(file)

    return values

aws_env = cdk.Environment(
    account=os.getenv('CDK_DEFAULT_ACCOUNT'),
    region="eu-west-1"
)

settings = load_settings()

app = cdk.App()

vpc_stack = VpcStack(
    scope=app,
    construct_id="group5-vpc",
    env=aws_env,
    settings=settings
)

data_stack = DataStack(
    scope=app,
    construct_id="group5-data",
    settings=settings,
    vpc=vpc_stack.vpc,
    env=aws_env,
)

app.synth()
