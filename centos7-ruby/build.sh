name=`basename ${PWD}`
tag=2020120401

main_registry=ietty
docker build -t ${main_registry}/${name}:${tag} .
docker login
docker push ${main_registry}/${name}:${tag}

