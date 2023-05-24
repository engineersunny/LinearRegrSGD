#### 6. Create a CICD pipeline using the technology of your choice to deploy your code to production. 
Think about what stages might be required in a full CICD pipeline. Your code should be invokable from a public URL.

Good diagram of CI/CD pipeline
https://www.cyberark.com/what-is/ci-cd-pipeline/


Version Control System (VCS):
Git to manage code and track changes


Continuous Integration (CI) Stage:
Triggered whenever changes are pushed to the repository.
Build your code and run tests to ensure it's working correctly.
Technologies: Jenkins, Travis CI, CircleCI, GitLab CI/CD


Artifact Repository:
Store the built artifacts (e.g., compiled binaries - pretrained model(parmas), packages) in a repository.
Technologies: Git LFS, AWS S3, Google Cloud Storage


Continuous Deployment (CD) Stage:
Push container image to Kubernetes cluster
Technologies: Kubernetes, Docker


Testing and Quality Assurance:
Unit tests, integration tests, and system tests.
Use static code analysis tools to ensure code quality and adherence to best practices.
Technologies: JUnit, Selenium, JMeter, SonarQube, ESLint, Pylint, etc.


Approval and Manual Testing:
Manual approval or user acceptance testing (UAT) before deploying to production.


Production Deployment:
Deploy the validated code to the production environment.
Technologies: Similar to the CD stage


Infrastructure as Code (IaC):
Define an infrastructure using code to ensure reproducibility and scalability. This enables us to set up monitoring for the containers, clusters, instances and more.
Technologies: Terraform, Datadog
