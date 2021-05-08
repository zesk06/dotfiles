# dotfiles

Mon environnement de dev, ma vie

## pour lancer

Voir [nvimd](https://raw.githubusercontent.com/zesk06/dotfiles/master/dotfiles/bin/bin/i3exithttps://raw.githubusercontent.com/zesk06/dotfiles/master/dotfiles/bin/bin/nvimd)

```bash

#!/bin/bash
# Command for running nvim in docker

if [[ "$1" = /* ]]; then
  file_name="$(basename ${1})"
  dir_name="$(dirname ${1})"
else
  file_name="$1"
  dir_name="$(pwd)"
fi
MUID=$(id -u)
MGID=$(id -g)
# Run the docker command
docker run -i -t -P -u ${MUID}:${MGID} -v "$dir_name":/src \
       zesk06/neovim:${MUID} /bin/zsh -c "cd /src; nvim $file_name"
```
