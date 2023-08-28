# PROJECT TERRAFORMATION 

> Generate 'SSH-KEYS' before running terraform script | FileName -> [ terraLOCK ] \

1. After the stack is deployed, replicate the source code onto your local machine.
2. Modify the application.properties file to include backend information. [ RDS | ElastiCache | ActiveMQ ]
3. Generate the Artifact by executing 'mvn install' in the project's root directory.
4. Manually place the artifact into Beanstalk Application Versions. OR
5. Setup CI/CD pipeline and you can employ Jenkins to automate the build and deployment of artifact.
6. Done
