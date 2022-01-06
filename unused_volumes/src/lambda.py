import json
import boto3
from common.logger_utility import *

# Knowledge base:
# https://relay.sh/blog/delete-unattached-ebs-volumes-with-python/
# https://aws.amazon.com/blogs/mt/controlling-your-aws-costs-by-deleting-unused-amazon-ebs-volumes/
def lambda_handler(event, context):
    
    LoggerUtility.setLevel(project='SDC Platform',
             team='DevOps',
             sdc_service='cleanup-worker',
             component='cleanup-worker')
    LoggerUtility.logInfo('cleanup-worker lambda started.')
    
    sess = boto3.Session(region_name='us-east-1')
    ec2 = sess.resource('ec2')
    volumes = ec2.volumes.all()
    
    to_terminate=[]
    for volume in volumes:
        # Here's where you might add other business logic for deletion criteria
        if len(volume.attachments) == 0:
            to_terminate.append(volume)
    
    if len(to_terminate) == 0:
        LoggerUtility.logInfo("No unused volumes to terminate. Exiting.")

    else:
        for volume in to_terminate:
            LoggerUtility.logInfo('Deleting volume {0}'.format(volume.id))
            volume.delete()

