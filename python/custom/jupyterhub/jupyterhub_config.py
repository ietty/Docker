import os
import logging
import subprocess
from oauthenticator.google import GoogleOAuthenticator
from fargatespawner import FargateSpawner
from fargatespawner import FargateSpawnerECSRoleAuthentication
c.FargateSpawner.authentication_class = FargateSpawnerECSRoleAuthentication

hosted_domain = os.getenv('HOSTED_DOMAIN')

c.JupyterHub.authenticator_class = GoogleOAuthenticator
c.GoogleOAuthenticator.hosted_domain = [hosted_domain]

c.Spawner.notebook_dir = "/mnt"
c.Spawner.default_url = "/tree/jupyter"
c.Spawner.cmd = ["jupyter-labhub"]

c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.log_level = logging.DEBUG


"""
class MyFargateSpawner(FargateSpawner):
    def start(self):
        return super().start()

c.JupyterHub.spawner_class = MyFargateSpawner
c.MyFargateSpawner.aws_region = 'ap-northeast-1'

c.MyFargateSpawner.get_run_task_args = lambda spawner: {
    'cluster': 'staging-ecs',
    'taskDefinition': 'fargate-nlp-def:1',
    'overrides': {
        'taskRoleArn': 'arn:aws:iam::888777505088:role/cdk-ecs-task-general',
        'containerOverrides': [{
            'command': spawner.cmd + [f'--port={spawner.notebook_port}', '--config=notebook_config.py'],
            'environment': [
                {
                    'name': name,
                    'value': value,
                } for name, value in spawner.get_env().items()
            ],
            'name': 'fargate-nlp',
        }],
    },
    'count': 1,
    'launchType': 'FARGATE',
    'networkConfiguration': {
        'awsvpcConfiguration': {
            'assignPublicIp': 'DISABLED',
            'securityGroups': ['sg-82ff99fa'],
            'subnets':  ['subnet-0b3081ee24472691d'],
        },
    },
}

"""