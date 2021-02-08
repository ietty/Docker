name=`basename ${PWD}`
tag=latest

registry=ietty
docker build -t ${registry}/${name}:${tag} .
docker login
docker push ${registry}/${name}:${tag}

registry=public.ecr.aws/b5w9v1j5
docker build -t ${registry}/${name}:${tag} .
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/b5w9v1j5
docker push ${registry}/${name}:${tag}
