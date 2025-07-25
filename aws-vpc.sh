aws ec2 create-vpc --cidr-block "10.0.0.0/16" --instance-tenancy "default" --tag-specifications '{"resourceType":"vpc","tags":[{"key":"Name","value":"openshift-vpc"}]}' 
aws ec2 modify-vpc-attribute --vpc-id "preview-vpc-1234" --enable-dns-hostnames '{"value":true}' 
aws ec2 describe-vpcs --vpc-ids "preview-vpc-1234" 
aws ec2 create-vpc-endpoint --vpc-id "preview-vpc-1234" --service-name "com.amazonaws.ap-southeast-1.s3" --tag-specifications '{"resourceType":"vpc-endpoint","tags":[{"key":"Name","value":"openshift-vpce-s3"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.0.0/20" --availability-zone "ap-southeast-1a" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"openshift-subnet-public1-ap-southeast-1a"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.16.0/20" --availability-zone "ap-southeast-1b" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"openshift-subnet-public2-ap-southeast-1b"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.32.0/20" --availability-zone "ap-southeast-1c" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"openshift-subnet-public3-ap-southeast-1c"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.128.0/20" --availability-zone "ap-southeast-1a" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"openshift-subnet-private1-ap-southeast-1a"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.144.0/20" --availability-zone "ap-southeast-1b" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"openshift-subnet-private2-ap-southeast-1b"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.160.0/20" --availability-zone "ap-southeast-1c" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"openshift-subnet-private3-ap-southeast-1c"}]}' 
aws ec2 create-internet-gateway --tag-specifications '{"resourceType":"internet-gateway","tags":[{"key":"Name","value":"openshift-igw"}]}' 
aws ec2 attach-internet-gateway --internet-gateway-id "preview-igw-1234" --vpc-id "preview-vpc-1234" 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"openshift-rtb-public"}]}' 
aws ec2 create-route --route-table-id "preview-rtb-public-0" --destination-cidr-block "0.0.0.0/0" --gateway-id "preview-igw-1234" 
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-0" 
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-1" 
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-2" 
aws ec2 allocate-address --domain "vpc" --tag-specifications '{"resourceType":"elastic-ip","tags":[{"key":"Name","value":"openshift-eip-ap-southeast-1a"}]}' 
aws ec2 create-nat-gateway --subnet-id "preview-subnet-public-0" --allocation-id "preview-eipalloc-0" --tag-specifications '{"resourceType":"natgateway","tags":[{"key":"Name","value":"openshift-nat-public1-ap-southeast-1a"}]}' 
aws ec2 describe-nat-gateways --nat-gateway-ids "preview-nat-0" --filter '{"Name":"state","Values":["available"]}' 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"openshift-rtb-private1-ap-southeast-1a"}]}' 
aws ec2 create-route --route-table-id "preview-rtb-private-1" --destination-cidr-block "0.0.0.0/0" --nat-gateway-id "preview-nat-0" 
aws ec2 associate-route-table --route-table-id "preview-rtb-private-1" --subnet-id "preview-subnet-private-3" 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"openshift-rtb-private2-ap-southeast-1b"}]}' 
aws ec2 create-route --route-table-id "preview-rtb-private-2" --destination-cidr-block "0.0.0.0/0" --nat-gateway-id "preview-nat-0" 
aws ec2 associate-route-table --route-table-id "preview-rtb-private-2" --subnet-id "preview-subnet-private-4" 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"openshift-rtb-private3-ap-southeast-1c"}]}' 
aws ec2 create-route --route-table-id "preview-rtb-private-3" --destination-cidr-block "0.0.0.0/0" --nat-gateway-id "preview-nat-0" 
aws ec2 associate-route-table --route-table-id "preview-rtb-private-3" --subnet-id "preview-subnet-private-5" 
aws ec2 describe-route-tables --route-table-ids    "preview-rtb-private-1" "preview-rtb-private-2" "preview-rtb-private-3" 
aws ec2 modify-vpc-endpoint --vpc-endpoint-id "preview-vpce-1234" --add-route-table-ids "preview-rtb-private-1" "preview-rtb-private-2" "preview-rtb-private-3" 
