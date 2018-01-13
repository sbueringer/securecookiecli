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
  echo "Running on travis-ci"
else
  echo "Running not on travis-ci"

  sudo chown fedora dist/securecookiecli
  sudo chmod +x dist/securecookiecli
fi
