{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                 "ec2:RunInstances",
                 "ec2:AssociateIamInstanceProfile",
                 "ec2:ReplaceIamInstanceProfileAssociation",
                 "iam:PassRole",
                 "s3:*"
            ],
            "Resource": "*"
        }
    ]
}