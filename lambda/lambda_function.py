import boto3
import snowflake.connector
import os

def handler(event, context):
    # Connect to Snowflake
    conn = snowflake.connector.connect(
        user=os.getenv('SNOWFLAKE_USER'),
        password=os.getenv('SNOWFLAKE_PASSWORD'),
        account=os.getenv('SNOWFLAKE_ACCOUNT')
    )
    cursor = conn.cursor()

    # Extract S3 bucket and file info
    s3 = boto3.client('s3')
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Process file (for simplicity, assume CSV format)
    response = s3.get_object(Bucket=bucket, Key=key)
    data = response['Body'].read().decode('utf-8').splitlines()
    
    # Insert data into Snowflake
    for row in data:
        cursor.execute(f"INSERT INTO raw.customer_data VALUES ({row})")
    
    cursor.close()
    conn.close()

    return {'statusCode': 200, 'body': 'Data loaded to Snowflake'}

