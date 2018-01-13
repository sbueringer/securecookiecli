#!/usr/bin/env bash

WORKDIR=`echo $0 | sed -e s/build.sh//`
cd ${WORKDIR}

FOLDER=/gopath/src/github.com/sbueringer/securecookiecli

rm -rf dist
mkdir dist

echo "Building Linux binary securecookiecli:"
docker run -e GOOS=linux -e GOARCH=amd64 -e GOPATH=/gopath -e CGO_ENABLED=0 \
           -v $(pwd):$FOLDER \
           -v $(pwd)/dist:/dist \
           -w $FOLDER  \
           golang:1.9.2 \
           sh -c "go get -v -d ./...; \
                  go build -a -installsuffix cgo -gcflags '-N -l' -ldflags='-s -w' -v -o /dist/securecookiecli"

echo "Building Windows binary securecookiecli:"
docker run -e GOOS=windows -e GOARCH=amd64 -e GOPATH=/gopath -e CGO_ENABLED=0 \
           -v $(pwd):$FOLDER \
           -v $(pwd)/dist:/dist \
           -w $FOLDER  \
           golang:1.9.2 \
           sh -c "go get -v -d ./...; \
                  go build -a -installsuffix cgo -gcflags '-N -l' -ldflags='-s -w' -v -o /dist/securecookiecli.exe"

if [ "$TRAVIS" == "true" ]
then
  echo "Downloading upx"
  curl -L -O https://github.com/upx/upx/releases/download/v3.93/upx-3.93-amd64_linux.tar.xz
  tar xvf upx-3.93-amd64_linux.tar.xz
  export PATH=$(pwd)/upx-3.93-amd64_linux:$PATH

  echo "Using upx on securecookiecli"
  upx ./dist/securecookiecli

  echo "Using upx on securecookiecli.exe"
  upx ./dist/securecookiecli.exe
else
  sudo chown fedora dist/securecookiecli
  sudo chmod +x dist/securecookiecli
fi
