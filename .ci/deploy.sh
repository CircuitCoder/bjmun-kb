#!/bin/sh

openssl aes-256-cbc -d -K $enc_key -iv $enc_iv -in .ci/key.enc -out .ci/key

eval "$(ssh-agent -s)"
chmod 600 .ci/key
ssh-add .ci/key
rsync -r ./_book/* $deploy_dest --delete-after
