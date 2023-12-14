import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import { Vpc, InstanceType, SubnetType } from "aws-cdk-lib/aws-ec2";
import { Role, ServicePrincipal, ManagedPolicy } from "aws-cdk-lib/aws-iam";
import {
  Cluster,
  KubernetesVersion,
  NodeType,
  EksOptimizedImage,
} from "aws-cdk-lib/aws-eks";
import {
  AutoScalingGroup,
  UpdatePolicy,
  BlockDeviceVolume,
  EbsDeviceVolumeType,
} from "aws-cdk-lib/aws-autoscaling";
// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class EksSelfManagedStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new Vpc(this, "EKS-VPC"); // create a new VPC for cluster

    // IAM role for our EC2 worker nodes
    const workerRole = new Role(this, "EKSWorkerRole", {
      assumedBy: new ServicePrincipal("ec2.amazonaws.com"),
    });
    workerRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("AmazonEKSClusterPolicy")
    );
    workerRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("AmazonEKSServicePolicy")
    );

    const eksCluster = new Cluster(this, "EKS-demo", {
      vpc: vpc,
      defaultCapacity: 0, // we want to manage capacity our selves
      version: KubernetesVersion.V1_28,
    });

    const onDemandASG = new AutoScalingGroup(this, "OnDemandASG", {
      vpc: vpc,
      role: workerRole,
      minCapacity: 1,
      maxCapacity: 5,
      instanceType: new InstanceType("t3.small"),
      machineImage: new EksOptimizedImage({
        kubernetesVersion: "1.28",
        nodeType: NodeType.STANDARD, // without this, incorrect SSM parameter for AMI is resolved
      }),
      blockDevices: [
        {
          deviceName: "gp3-volume",
          volume: BlockDeviceVolume.ebs(30, {
            volumeType: EbsDeviceVolumeType.GP3,
            throughput: 125,
          }),
        },
      ],
      updatePolicy: UpdatePolicy.rollingUpdate(),
    });

    eksCluster.connectAutoScalingGroupCapacity(onDemandASG, {});
  }
}
