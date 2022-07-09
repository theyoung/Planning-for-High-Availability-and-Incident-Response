# aws ec2 copy-image --source-image-id ami-0b404d0db27a8f9c9 --source-region us-east-1 --region us-east-2 --name "udacity-project2"
# {
#     "ImageId": "ami-0aee2b1db728f949b"
# }
module "project_ec2" {
  source             = "./modules/ec2"
  instance_count     = var.instance_count
  name               = local.name
  account            = data.aws_caller_identity.current.account_id
  aws_ami            = "ami-0aee2b1db728f949b"
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
}