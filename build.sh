#!/bin/bash
release=$(cat release)
echo "Gerando relase: ${release}"

# Gera uma build
docker build -t luisos:latest -t luisos:${release} .
hash=$(docker images | grep ${release} | awk '{print $3}' | uniq)

# Tagueia a imagem e a salva no registro
# docker tag ${hash} docker.rentcars.lan:5000/rentos:${release}
# docker tag ${hash} docker.rentcars.lan:5000/rentos:latest
# docker push docker.rentcars.lan:5000/rentos:${release}
# docker push docker.rentcars.lan:5000/rentos:latest
