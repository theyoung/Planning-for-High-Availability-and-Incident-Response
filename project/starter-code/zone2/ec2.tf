#  module "project_ec2" {
#    source             = "./modules/ec2"
#    name               = local.name
#    account            = data.aws_caller_identity.current.account_id
#    aws_ami            = data.aws_ami.amazon_linux_2.id
#    private_subnet_ids = module.vpc.private_subnet_ids
#    vpc_id             = module.vpc.vpc_id
#  }

# aws ec2 copy-image --source-image-id ami-0f576df7017cdb201 --source-region us-east-1 --region us-west-1 --name "udacity-theyoung11"
# {
#     "ImageId": "ami-0ad91c5d8ae434d95"
# }

  module "project_ec2" {
   source             = "./modules/ec2"
   instance_count     = var.instance_count
   name               = local.name
   account            = data.aws_caller_identity.current.account_id
   aws_ami            = "ami-0ad91c5d8ae434d95"
   private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
   public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids
   vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
 }