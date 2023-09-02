# TERRAFORMATION - AWS
![aws_stack_terraform_workflow_1](https://github.com/abhishekm89/terraform/blob/e3eb0cae648526847f2fe587a91607b39251676e/aws_stack_terraform_workflow_1.png)

## Preparation Step:
  - Generate SSH Keys Before Running Terraform Script. [terraLOCK]

## Deployment and Configuration Steps for Your Application
  1. After the stack is deployed, replicate the source code onto your local machine.
  2. Modify the application.properties file to include backend information. [ RDS | ElastiCache | ActiveMQ ]
  3. Generate the Artifact by executing 'mvn install' in the project's root directory.
  4. Manually place the artifact into Beanstalk Application Versions. OR
  5. Setup CI/CD pipeline and you can employ Jenkins to automate the build and deployment of artifact.
  6. Done
