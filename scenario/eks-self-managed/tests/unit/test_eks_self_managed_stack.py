import aws_cdk as core
import aws_cdk.assertions as assertions

from eks_self_managed.eks_self_managed_stack import EksSelfManagedStack

# example tests. To run these tests, uncomment this file along with the example
# resource in eks_self_managed/eks_self_managed_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = EksSelfManagedStack(app, "eks-self-managed")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
