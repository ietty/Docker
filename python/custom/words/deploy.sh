docker rm -vf sagemaker
docker run -d --name sagemaker \
  -v ~/.aws:/home/docker/.aws \
  -v ~/.git-credentials:/home/docker/.git-credentials \
  -v ~/.gitconfig:/home/docker/.gitconfig \
  -v cdk-data:/home/docker/cdk \
  ietty/sagemaker:latest tail -f /dev/null

