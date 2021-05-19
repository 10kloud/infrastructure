from aws_cdk import (
    core as cdk,
    aws_ec2 as ec2
)

class VpcStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # Virtual Private Cloud to contain every resource needed for the project
        # DOCS: https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.aws_ec2/Vpc.html
        self.vpc = ec2.Vpc(
            self,
            id="clod2021-group5",
            cidr="10.0.0.0/16",
            # Maximum number of Availability Zones to use in this region
            max_azs=2,
            # Subnets for each AZ
            # Each entry is a subnet group that contains a subnet for each AZ
            subnet_configuration=[
                # Public subnet for the EC2 instances
                # in which the core of the system is located
                ec2.SubnetConfiguration(
                    name="clod2021-group5-system-core",
                    cidr_mask=24,
                    reserved=False,
                    subnet_type=ec2.SubnetType.PUBLIC
                ),
                # Isolated subnet for the databases
                ec2.SubnetConfiguration(
                    name="clod2021-group5-database",
                    cidr_mask=24,
                    reserved=False,
                    subnet_type=ec2.SubnetType.ISOLATED
                )
            ],

            # Expose public networks behind a NAT system
            nat_gateways=1,
            nat_gateway_provider=ec2.NatProvider.gateway(),
            # Which subnets need to have a NAT gateway
            # Default: All public networks
            # nat_gateway_subnets=ec2.SubnetSelection()

            # Instances in this VPC will acquire a public DNS hostname
            enable_dns_hostnames=True,
            enable_dns_support=True,
        )

        cdk.CfnOutput(
            self,
            id="vpc_id",
            value=self.vpc.vpc_id,
            description="VPC ID",
            export_name=f"{self.region}:{self.account}:{self.stack_name}:vpc-id"
        )
