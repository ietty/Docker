vagrant up
vagrant package

URL=https://atlas.hashicorp.com/api/v1/box/takemi-ohama/devbase
TOKEN=1EvqH9NozeLPkA.atlasv1.6ev9NoozbzBV7qr8dI61omJVXrHCvdbe4qhvzaj1pltQJogjDfZRFgLZqNcuoxIOTrM
VERSION=1.1.0

curl $URL/versions -X POST -d version[version]=$VERSION -d access_token=$TOKEN
curl $URL/version/$VERSION/providers -X POST -d provider[name]='virtualbox' -d access_token=$TOKEN
curl $URL/version/$VERSION/provider/virtualbox/upload?access_token=$TOKEN > key.json
UPLOAD=`cut -d '"' -f 4 key.json`
curl -X PUT --upload-file package.box $UPLOAD
rm -f key.json
