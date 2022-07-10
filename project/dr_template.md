# Infrastructure

## AWS Zones
- Working Zone : us-east-2
- DR Zone : us-west-1

## Servers and Clusters

### Table 1.1 Summary
| Asset                    | Purpose                                                      | Size      | Qty                                                          | DR                                                           |
| ------------------------ | ------------------------------------------------------------ | --------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| EC2 (Working)            | Application Servers, where Flask Application running.        | t3.micro  | 3                                                            | replicated to the DR Zone (us-west-1)                        |
| EC2 (DR)                 | Application Servers for DR, where Flask Application running. | t3.micro  | 3                                                            | Assets for replacement when DR occurs in the working zone (us-east-2). |
| EKS Cluster and Nodes    | It consists of Control Plane and Nodes to operate Prometheus and Grafana services. | t3.medium | 1 cluster and 2 nodes (Working)<br />1 cluster and 2 nodes (DR) | replicated to the DR Zone (us-west-1)                        |
| VPC                      | Virtual Private Cloud (VPC) enables Network for applications. |           |                                                              | Deployed in Working and DR zone both                         |
| Load Balancer            | Distribute network traffic to improve application scalability and availability for flask. |           |                                                              | Deployed in Working and DR zone both                         |
| RDS Cluster and Database | Data repository for application. It consists of 1 cluster and 2(read, write) databases in the working and dr zone, respectfully. | t3.small  | 2 databases (working)<br />2 databases<br />(DR)             | Deployed in Working and DR zone both and replicated from working region. |

### Descriptions
- EC2 : It is an instance of Ubuntu-Web. Flask application is working. Ingress opens port 80 for service and port 22 for ssh. If the working zone fails, it must be changed to the DR zone by changing the DNS (route 53) setting.
- EKS : EKS is used by Prometheus and Grafana Service to measure and monitor metrics of user applications and instances. For high availability, each working zone and DR zone have EKS, and two nodes are also configured.
- VPC : For high availability, VPCs are located in "us-east-2a", "us-east-2b", "us-east-2c" for the working zone. And "us-west-1b", "us-west" for the dr zone.
- Load Balancer : High availability and scalability can be obtained by distributing 80 port traffics coming into the working zone and the DR zone to the running EC2.
- RDS Cluster : One master cluster has a reading and writing database in the working zone. And by placing a slave cluster in the DR zone and periodically reading and moving the data of the master cluster, reliability is improved.



## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

- Ensure both sites are configured the same (us-east-2 and us-west-1)
- Ensure the DR site working properly as the working site does. (us-west-1)
- Use infrastructure as code (IaC) to build DR site, automatically. (zone2 or us-west-1)

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

- Use DNS Service (Amazon route 53) and change IP point to DR zone (us-west-1)
  - Create a cloud load balancer to point to an application instance group in DR zone
  - The IP of the load balancer in DR will be applied in DNS Service
- Keep a database replication instances to another region (DR zone, us-west-1)
  - Manually force the secondary region(us-west-1) to become primary at the database level
  - or, Automatically failover the database by health checks