# Required for returning the same class the builder is building
from __future__ import annotations

from aws_cdk import (
    aws_ec2 as ec2
)

class Ec2InstanceBuilder:
    def set_instance_class(self, instance_class: ec2.InstanceClass) -> Ec2InstanceBuilder:
        # Default value
        self.instance_class = ec2.InstanceClass.BURSTABLE2

        if instance_class == "t2":
            self.instance_class = ec2.InstanceClass.BURSTABLE2
        elif instance_class == "t3":
            self.instance_class = ec2.InstanceClass.BURSTABLE3
        elif instance_class == "t3a":
            self.instance_class = ec2.InstanceClass.BURSTABLE3_AMD
        # And so on...
        # It's just an example, add more elifs to implement other instance classes

        return self

    def set_instance_size(self, instance_size: ec2.InstanceSize) -> Ec2InstanceBuilder:
        # Default value
        self.instance_size = ec2.InstanceSize.NANO

        if instance_size == "nano":
            self.instance_size = ec2.InstanceSize.NANO
        elif instance_size == "micro":
            self.instance_size = ec2.InstanceSize.MICRO
        elif instance_size == "medium":
            self.instance_size = ec2.InstanceSize.MEDIUM
        elif instance_size == "large":
            self.instance_size = ec2.InstanceSize.LARGE
        # And so on...
        # It's just an example, add more elifs to implement other instance sizes

        return self

    def build(self) -> ec2.InstanceType:
        return ec2.InstanceType.of(
            instance_class = self.instance_class,
            instance_size = self.instance_size
        )
