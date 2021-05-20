from aws_cdk import (
    aws_ec2 as ec2
)

class VpcModel:

    def __init__(self, settings: dict):
        self.id = settings.get("id", "")
        self.cidr = settings.get("cidr", "")

        subnet_configuration = settings.get("subnets", [])
        self.subnets = self._configure_subnets(subnet_configuration)

        self.availability_zones = settings.get("availability_zones", 2)
        self.nat_gateways = settings.get("nat_gateways", 1)


    def _subnet_type_from_string(self, subnet_type: str) -> ec2.SubnetType:
        if subnet_type.lower() == "private":
            return ec2.SubnetType.PRIVATE

        elif subnet_type.lower() == "isolated":
            return ec2.SubnetType.ISOLATED

        return ec2.SubnetType.PUBLIC


    def _configure_subnets(self, subnet_configuration: list) -> list:
        subnets = list()

        for conf in subnet_configuration:
            subnet_type = conf.get("type", "")

            subnets.append(
                ec2.SubnetConfiguration(
                    name = conf.get("name"),
                    cidr_mask = conf.get("cidr_mask"),
                    reserved = False,
                    subnet_type = self._subnet_type_from_string(subnet_type)
                )
            )

        return subnets
