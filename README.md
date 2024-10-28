# Automated Data Pipeline from AWS to Snowflake

## Overview
This project automates the ingestion of raw customer data from AWS S3 into Snowflake, where data is transformed with dbt for analytics.

### Architecture
![Architecture Diagram](images/architecture_diagram.png)

## Components
- **Terraform**: Sets up AWS resources.
- **AWS Lambda**: Loads new data from S3 to Snowflake.
- **dbt**: Transforms raw data into analytics-ready tables.
- **Tableau**: Visualizes data (not included but recommended as a final step).

## Setup Instructions
1. **Terraform**: Deploy AWS infrastructure.
   ```bash
   cd terraform
   terraform init
   terraform apply

