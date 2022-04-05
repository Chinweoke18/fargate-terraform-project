NOTE: i assumed that we will be havig multiple microservices, therefore there is need to make provission for each of the microservices. Inotherwords, there will be a section of the code that is general to all the microservice and a section specific to the microservices.

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

Number 2: This is the section specific to the the microservice. These includes:
- task definitin
- ECS service and its security group
- target group
- service autoscaling
This I have done having in mind that the microservices might not have thesame ports nor require thesame resource specifications

In this task, I have made a file for the microservice nginx which i used to test, it contains also the avrs that a specific to the microservice.
