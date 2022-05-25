docker rm -vf test 
docker run -d --name test \
  -v ~/.aws:/home/docker/.aws \
  -v ~/.git-credentials:/home/docker/.git-credentials \
  -v ~/.gitconfig:/home/docker/.gitconfig \
  -e HOSTED_DOMAIN=ietty.co.jp \
  -e OAUTH_CLIENT_ID=1079595221867-rmalm0buebci983td30nloa029vapn95.apps.googleusercontent.com \
  -e OAUTH_CLIENT_SECRET=4JbvXLwK_MJL_34jz9PR3PNV \
  -e OAUTH_CALLBACK_URL=https://jupyter.ietty.me/hub/oauth_callback \
  -p 8080:8000 \
  ietty/jupyterhub:2022041901

