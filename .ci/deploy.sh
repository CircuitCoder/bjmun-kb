#!/bin/sh

eval "$(ssh-agent -s)"
chmod 600 .ci/key
ssh-add .ci/key
rsync -av -e "ssh -o StrictHostKeyChecking=no" ./_book/ $deploy_dest --delete-after
