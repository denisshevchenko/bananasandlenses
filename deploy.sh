#!/bin/bash
set -eux

readonly COMMIT_MESSAGE=$1
readonly PATH_TO_MP3=$2

echo "Add new episode post..."
git add .
git commit -a -m "${COMMIT_MESSAGE}"

echo "Upload audio record to server..."
scp "${PATH_TO_MP3}" dshevchenko@bananasandlenses.net:public_html/audio/

echo "Publish new episode post..."
git push origin master

echo "Done."
