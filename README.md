NOTE: I assumed that we will be havig multiple microservices, therefore there is need to make provission for each of the microservices. Inotherwords, there will be a section of the code that is general to all the microservice and a section specific to the microservices.

This code is sectioned into two parts:

Number 1: This is the resources that is general to all the microservice, this includes:
- VPC
- Subnets
- Nat gateways
- route table
- application loadbalancer and its security group
- ECS cluster
- Iam policy execution role
- cloudwatch log group

Number 2: This is the section specific to the the microservice. this includes:
- task definitin
- ECS service and its security group
- target group
- service autoscaling
This I have done having in mind that the microservices might not have thesame ports nor require thesame resource specifications

In this task, I have made a file for the microservice "nginx" which I used for thr test, it contains also the avrs that a specific to the microservice.


Networking:
The code creates a VPC, 3 public subnet and 3 private subnet. The public subnets are attached to a routetable and attached to an internet gateway.
The private subnets are attached to a route table and a NAT gateway attached to the route table. 
3 NAT gateways are equally created for the 3 prvate subnets.

Deployments:

The Loadbalancer is attached to the 3 public sunbets in the different availablibity zones. This is to create the redundancy we need incase of failure of any of the zones.

The Applications are deployed in the Private subnets, in the there availability zones. Failure of any of the availability zones or the app in any of the availability zones does not affect the application.
The auto scalling configuration is also availae to scale the pods if need arises

