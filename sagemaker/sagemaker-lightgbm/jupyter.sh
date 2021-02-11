#!/bin/bash

set -e

# PARAMETERS
IDLE_TIME=43200
BASEPATH=/home/ec2-user/SageMaker/lib

mkdir -p $BASEPATH
echo "Fetching the autostop script"
wget https://raw.githubusercontent.com/aws-samples/amazon-sagemaker-notebook-instance-lifecycle-config-samples/master/scripts/auto-stop-idle/autostop.py -O $BASEPATH/autostop.py

echo "Starting the SageMaker autostop script in cron"
(crontab -l 2>/dev/null; echo "5 * * * * /usr/bin/python $BASEPATH/autostop.py --time $IDLE_TIME --ignore-connections") | crontab

echo "set terminal-extension"
plugins=/home/ec2-user/.jupyter/lab/user-settings/@jupyterlab/terminal-extension
[ ! -d "$plugins" ] && mkdir -p $plugins
cat <<EOF > $plugins/plugin.jupyterlab-settings
{
    "fontFamily": "monaco,Consolas",
    "fontSize": 13,
    "theme": "dark"
}
EOF

echo "set auto translate .ipynb to .py"
jbconfig=/home/ec2-user/.jupyter/jupyter_notebook_config.py
cat <<EOF >> $jbconfig
import io
import os
from notebook.utils import to_api_path
_script_exporter = None
def script_post_save(model, os_path, contents_manager, **kwargs):
    from nbconvert.exporters.script import ScriptExporter
    if model['type'] != 'notebook':
        return
    global _script_exporter
    if _script_exporter is None:
        _script_exporter = ScriptExporter(parent=contents_manager)
    log = contents_manager.log
    dir, filename = os.path.split(os_path)
    script_dir = os.path.join(dir, 'pylib')
    base, ext = os.path.splitext(filename)
    script, resources = _script_exporter.from_filename(os_path)
    script_fname = os.path.join(script_dir,base + resources.get('output_extension', '.py'))
    log.info("Saving script /%s", to_api_path(script_fname, contents_manager.root_dir))
    os.makedirs(script_dir, exist_ok=True)
    with io.open(script_fname, 'w', encoding='utf-8') as f:
        f.write(script)
c.FileContentsManager.post_save_hook = script_post_save
c.EnvironmentKernelSpecManager.conda_env_dirs = ['~/SageMaker/lib/envs','~/anaconda3/envs']
EOF

chown -R ec2-user:ec2-user /home/ec2-user/.jupyter

echo "Install Japanese fonts"
yum install -y ipa-gothic-fonts ipa-mincho-fonts

echo "change terminal shell to bash"
echo "export SHELL=/bin/bash" >> /etc/profile.d/jupyter-env.sh
echo "export CONDA_ENVS_PATH=$BASEPATH/envs" >> /etc/profile.d/jupyter-env.sh
echo "export PYTHONPATH=/home/ec2-user/SageMaker/AmazonSageMaker-with-ai/mllib/pylib:$PYTHONPATH" >> /etc/profile.d/jupyter-env.sh

initctl restart jupyter-server --no-wait
