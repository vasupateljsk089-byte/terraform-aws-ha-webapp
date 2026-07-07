# AWS Auto Scaling Web Application Infrastructure 

> **Goal:** Deploy a production-style highly available web application
> on AWS using Terraform modules.

------------------------------------------------------------------------

# Architecture diagram

![alt text](/images/diagram.png)

# 📁 Project Structure

``` text
terraform/
│
├── bootstrap/                  # S3 backend & DynamoDB lock
│
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── provider.tf
│       ├── versions.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── main.tf             # Calls all modules
│
└── modules/
    ├── vpc/
    ├── security-group/
    ├── alb/
    ├── target-group/
    ├── launch-template/
    └── autoscaling/
```

------------------------------------------------------------------------

# 🏗 Infrastructure Build Order

``` text
Bootstrap
   │
Terraform Init
   │
VPC
   │
Security Groups
   │
Application Load Balancer
   │
Target Group
   │
Golden AMI
   │
Launch Template
   │
Auto Scaling Group
   │
Scaling Policy
   │
Listener
   │
DNS (Route53 / Hostinger)
```

------------------------------------------------------------------------

# Step 0 -- Bootstrap

Create the resources required before running Terraform.

-   S3 Bucket (Remote State)
-   DynamoDB Table (State Lock)
-   Backend Configuration

Run later from the environment directory:

``` bash
terraform init
```

------------------------------------------------------------------------

# Step 1 -- Configure Terraform

Create:

-   versions.tf
-   provider.tf
-   backend.tf
-   variables.tf
-   outputs.tf
-   main.tf

------------------------------------------------------------------------

# Step 2 -- Create VPC

Resources:

-   VPC
-   Public Subnets
-   Private Subnets
-   Internet Gateway
-   NAT Gateway
-   Elastic IP
-   Public Route Table
-   Private Route Table

Outputs:

-   VPC ID
-   Public Subnet IDs
-   Private Subnet IDs

------------------------------------------------------------------------

# Step 3 -- Create Security Groups

### ALB Security Group

Inbound

-   HTTP (80)
-   HTTPS (443)

Outbound

-   All Traffic

### EC2 Security Group

Inbound

-   HTTP (80) from ALB Security Group
-   SSH (Optional)
-   SSM (IAM Role)

Outbound

-   All Traffic

Outputs

-   ALB Security Group ID
-   EC2 Security Group ID

------------------------------------------------------------------------

# Step 4 -- Create Application Load Balancer

Resources

-   ALB
-   ACM Certificate (Optional)
-   ALB Security Group

Outputs

-   ALB ARN
-   ALB DNS
-   Listener ARN

------------------------------------------------------------------------

# Step 5 -- Create Target Group

Configure

-   Health Check Path
-   Interval
-   Healthy Threshold
-   Unhealthy Threshold

Output

-   Target Group ARN

------------------------------------------------------------------------

# Step 6 -- Build the Golden AMI

Launch a temporary EC2.

Install:

-   Docker
-   Application
-   Dependencies
-   Monitoring Agent (Optional)

Verify the application.

Create an AMI.

Terminate the temporary EC2.

## AMI Stores

✅ Operating System

✅ Installed Packages

✅ Application Files

✅ Root EBS Snapshot

✅ Additional EBS Snapshots (Optional)

## AMI Does NOT Store

❌ Instance Type

❌ VPC

❌ Subnet

❌ Security Groups

❌ IAM Role

❌ Key Pair

❌ Public / Private IP

❌ Auto Scaling Group

------------------------------------------------------------------------

# Step 7 -- Create Launch Template

Include

-   AMI ID
-   Instance Type
-   Security Group
-   IAM Instance Profile
-   User Data
-   IMDSv2 Metadata Options
-   EC2 & EBS Tags

Output

-   Launch Template ID

------------------------------------------------------------------------

# Step 8 -- Create Auto Scaling Group

Attach

-   Launch Template
-   Private Subnets
-   Target Group

Configure

-   Desired Capacity
-   Minimum Capacity
-   Maximum Capacity
-   ELB Health Check
-   Health Check Grace Period
-   Instance Refresh
-   Lifecycle Rules

Output

-   Auto Scaling Group Name

------------------------------------------------------------------------

# Step 9 -- Configure Auto Scaling Policy

Target Tracking

Metric:

-   ASGAverageCPUUtilization

Target Example:

-   50%

Result:

-   Scale Out → High CPU
-   Scale In → Low CPU

------------------------------------------------------------------------

# Step 10 -- Create Listener

HTTP

-   Port 80

HTTPS

-   Port 443
-   ACM Certificate

Forward Requests

→ Target Group

------------------------------------------------------------------------

# Step 11 -- Configure DNS

Example

``` text
app.vasubhalani.in
        │
        ▼
Application Load Balancer DNS
```

-   Route53 → Alias Record
-   Hostinger → CNAME Record

------------------------------------------------------------------------

# Step 12 -- Validation Checklist

-   VPC created
-   ALB accessible
-   Target Group healthy
-   EC2 instances healthy
-   User Data executed
-   Auto Scaling working
-   CloudWatch metrics available
-   HTTPS working
-   DNS resolving correctly

------------------------------------------------------------------------

# Final Architecture

``` text
User
   │
DNS
   │
HTTPS
   │
ALB
   │
Listener
   │
Target Group
   │
Auto Scaling Group
   │
Launch Template
   │
AMI
   │
EC2 Instances
   │
Docker Container
   │
Application
```

------------------------------------------------------------------------

# Production Notes

-   Separate `dev`, `staging`, and `prod` environments.
-   Separate Terraform state for each environment.
-   Use reusable modules.
-   Store state remotely in S3.
-   Enable DynamoDB state locking.
-   Keep EC2 and EBS tagging in the Launch Template.
-   Use IMDSv2 for metadata security.
-   Use ACM for HTTPS.
-   Use Auto Scaling + ALB for High Availability.

-------------------------------------------------
# Output 


![alt text](</images/Screenshot 2026-07-08 000047.png>) 

![alt text](</images/Screenshot 2026-07-08 000034.png>)

![alt text](</images/Screenshot 2026-07-08 001521.png>)

![alt text](</images/Screenshot 2026-07-08 001436.png>)

![alt text](</images/Screenshot 2026-07-08 001401.png>)
