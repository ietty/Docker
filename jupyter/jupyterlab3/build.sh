name=`basename ${PWD}`
tag=`date +%Y%m%d`01

echo "tag: ${tag}"

registry=ietty
public_ecr=public.ecr.aws/b5w9v1j5
private_ecr=888777505088.dkr.ecr.us-west-2.amazonaws.com

docker build -t ${registry}/${name}:${tag} .

function pushDockerHub(){
    docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest
    docker login
    docker push ${registry}/${name}:${tag}
    docker push ${registry}/${name}:latest
    echo "pushed: ${registry}/${name}:${tag}"

}

function pushPublicECR(){
    aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${public_ecr}
    docker tag ${registry}/${name}:${tag} ${public_ecr}/${name}:${tag}
    docker push ${public_ecr}/${name}:${tag}
    echo "pushed: ${public_ecr}/${name}:${tag}"
}

function pushPrivateECR(){
    aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${private_ecr}
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:${tag}
    docker push ${private_ecr}/${name}:${tag}
    echo "pushed: ${private_ecr}/${name}:${tag}"
}

function createStudioApp(){
    profile=${1:-default}
    region=${2:-us-west-2}
    aws --profile=${profile} --region ${region} sagemaker create-image-version \
    --base-image ${private_ecr}/${name}:${tag} \
    --image-name ${name}
}


pushDockerHub
#pushPublicECR
#pushPrivateECR
#createStudioApp
