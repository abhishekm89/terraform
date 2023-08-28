# PROJECT TERRAFORMATION 

> Generate 'SSH-KEYS' before running terraform script | FileName -> [ terraLOCK ] \

1. After the stack is deployed, replicate the source code onto your local machine.
2. Modify the application.properties file to include backend information. [ RDS | ElastiCache | ActiveMQ ]
3. Generate the Artifact by executing 'mvn install' in the project's root directory.
4. Manually place the artifact into Beanstalk, or utilize Jenkins to generate artifact and deploy if you've established a CI/CD pipeline.
5. Done
