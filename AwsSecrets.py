import boto3
from botocore.exceptions import ClientError
import json
import os


class AwsSecrets:
    def __init__(self, profileName, secretsName, regionName):
        self.profileName = profileName
        self.secretsName = secretsName
        self.regionName = regionName
        self.certpath = os.environ.get('Aws_SSL_Db_cert')

        self.session = boto3.Session(profile_name=self.profileName, region_name=self.regionName)
        self.secretDict = self.getSecret()
        self.token = None

    def getSecret(self):
        client = self.session.client(service_name='secretsmanager',region_name=self.regionName)
        try:
            get_secret_value_response = client.get_secret_value(SecretId=self.secretsName)
            secret = get_secret_value_response['SecretString']
            return json.loads(secret)

        except ClientError as e:
            raise e

    def getdbToken(self):
        client = self.session.client('rds')
        token = client.generate_db_auth_token(DBHostname=self.secretDict['host'], Port=self.secretDict['port'], DBUsername=self.secretDict['username'], Region=self.regionName)
        return token

