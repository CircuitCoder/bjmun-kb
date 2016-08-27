#!/bin/sh

eval "$(ssh-agent -s)"
chmod 600 .ci/key
ssh-add .ci/key
rsync -av ./_book/ $deploy_dest --delete-after
