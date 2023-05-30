docker rm -vf test 
docker run -d --name test \
  -v ~/.aws:/home/docker/.aws \
  -v ~/.git-credentials:/home/docker/.git-credentials \
  -v ~/.gitconfig:/home/docker/.gitconfig \
  ietty/nlp:2022042101 tail -f /dev/null

