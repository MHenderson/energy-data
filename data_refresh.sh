#!/usr/bin/env bash

Rscript data-raw/tidy_energy.R

if [[ "$(git status --porcelain)" != "" ]]; then
    git config --global user.name 'MHenderson'
    git config --global user.email 'matthew.james.henderson@gmail.com'
    git add data/*
    git commit -m "data auto-update"
    git push origin master
else
echo "Nothing to commit..."
fi
