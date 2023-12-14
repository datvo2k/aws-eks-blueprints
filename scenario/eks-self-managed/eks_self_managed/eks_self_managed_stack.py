from aws_cdk import Stack, core, aws_ec2, aws_iam, aws_eks, aws_ecs, Tags
from constructs import Construct

class EksSelfManagedStack(Stack):

	def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
		super().__init__(scope, construct_id, **kwargs)
		
	def __create_vpc(self):
		
