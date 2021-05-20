from aws_cdk import (
    core as cdk,
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

class VpcStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, settings: dict = {}, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        vpc_settings = settings.get("vpc", {})
        model = VpcModel(vpc_settings)

        # Virtual Private Cloud to contain every resource needed for the project
        # DOCS: https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.aws_ec2/Vpc.html
        self.vpc = ec2.Vpc(
            self,
            id = model.id,
            # Network address using CIDR notation
            cidr = model.cidr,
            # Maximum number of Availability Zones to use in this region
            max_azs = model.availability_zones,
            # Subnets for each AZ
            # Each entry is a subnet group that contains a subnet for each AZ
            subnet_configuration = model.subnets,

            # Expose public networks behind a NAT system
            nat_gateways = model.nat_gateways,
            nat_gateway_provider=ec2.NatProvider.gateway(),
            # Which subnets need to have a NAT gateway
            # Default: All public networks
            # nat_gateway_subnets=ec2.SubnetSelection()
        )

        cdk.CfnOutput(
            self,
            id="vpc_id",
            value=self.vpc.vpc_id,
            description="VPC ID",
            export_name=f"{self.region}:{self.account}:{self.stack_name}:vpc-id"
        )
