#!/bin/bash

cd "$(dirname "$0")"

# anaconda
if ! command -v conda &> /dev/null; then
    wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
    bash Anaconda3-2020.11-Linux-x86_64.sh
    rm Anaconda3-2020.11-Linux-x86_64.sh
fi

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
