#!/bin/bash

SIZ_BRANCH= "test"
SIZ_ENV= "development"

while getopts ":b:" opt; do
  case $opt in
    b)
      echo "using branch flag!!!"
      if [ $OPTARG = "draft" ]; then
        SIZ_ENV= "staging"
      elif [ $OPTARG = "master" ]; then
        SIZ_ENV= "production"
      fi
      ;;
  esac
done

git checkout $SIZ_BRANCH && git pull
./node_modules/.bin/bower install
./node_modules/.bin/gulp post
./node_modules/.bin/harp compile harp dist
./node_modules/.bin/gulp after
./node_modules/.bin/divshot deploy $SIZ_ENV --token $DivshotToken
