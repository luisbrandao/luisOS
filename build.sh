#!/bin/bash
if [ -f release ]; then
   echo "Release file found. Using it"
   release=$(cat release)
else
   echo "Release file found. Using local"
   release="local"
fi

echo "Gerando relase: ${release}"

# Gera uma build
docker build -t luisos:latest -t luisos:${release} .
hash=$(docker images | grep ${release} | awk '{print $3}' | uniq)

# Tagueia a imagem e a salva no registro
# docker tag ${hash} registry.exemple.com:5000/luisos:${release}
# docker tag ${hash} registry.exemple.com:5000/luisos:latest
# docker push registry.exemple.com:5000/luisos:${release}
# docker push registry.exemple.com:5000/luisos:latest
