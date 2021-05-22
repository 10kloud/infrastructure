from aws_cdk import (
    core as cdk,
    aws_rds as rds
)

from models import PostgresRdsModel

class DataStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, vpc, settings: dict = {}, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        data_settings = settings.get("data", {})
        postgres_settings = data_settings.get("postgres", {})

        postgres_model = PostgresRdsModel(
            settings=postgres_settings,
            vpc=vpc
        )

        postgres_db = rds.DatabaseInstance(
            self,
            id = postgres_model.id,

            engine = postgres_model.engine,

            # Host instance
            instance_type = postgres_model.instance_type,

            # Networking
            vpc = postgres_model.vpc,
            vpc_subnets = postgres_model.vpc_subnets,
            multi_az = postgres_model.multi_az,

            # Storage
            allocated_storage = postgres_model.allocated_storage,
            storage_type = postgres_model.storage_type,
            deletion_protection = postgres_model.deletion_protection,
            delete_automated_backups = postgres_model.delete_automated_backups,
            backup_retention = postgres_model.backup_retention,

            database_name = postgres_model.database_name,
        )

        # 10% of the allocated storage
        storage_threshold = postgres_model.allocated_storage * 0.1

        postgres_db.metric_free_storage_space().create_alarm(
            self,
            "LowStorageLeft",
            threshold = storage_threshold,
            evaluation_periods = 5
        )
