from aws_cdk import (
    core as cdk,
    aws_rds as rds,
    aws_ec2 as ec2
)

from .ec2_instance_builder import Ec2InstanceBuilder

class PostgresEngineBuilder:
    def __init__(self, version: str):
        self.full_version = version
        self.major_version = version.split(".")[0]

    def build(self) -> rds.IInstanceEngine:
        return rds.DatabaseInstanceEngine.postgres(
            version=rds.PostgresEngineVersion.of(
                postgres_full_version = self.full_version,
                postgres_major_version = self.major_version,
            ),
        )

class PostgresRdsModel:

    def __init__(self, settings: dict, vpc):
        self.id = settings.get("id", "")

        # Engine
        self.engine = PostgresEngineBuilder(
            version = settings.get("version", "13.0")
        ).build()

        # Host instance
        instance_settings = settings.get("instance", {})
        self.instance_type = Ec2InstanceBuilder() \
            .set_instance_class(instance_settings.get("class", "t2")) \
            .set_instance_size(instance_settings.get("size", "micro")) \
            .build()

        # Networking
        self.multi_az = True
        self.vpc = vpc
        self.vpc_subnets = ec2.SubnetSelection(
            subnet_type = ec2.SubnetType.ISOLATED
        )

        # Storage
        self.allocated_storage = settings.get("storage", 20)
        self.storage_type = rds.StorageType.STANDARD
        self.deletion_protection = False
        self.delete_automated_backups = False
        self.backup_retention = cdk.Duration.days(5)

        db_settings = settings.get("database", {})
        self.database_name = db_settings.get("name", "database")
