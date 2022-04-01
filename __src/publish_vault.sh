#!/usr/bin/env bash

# Config
CONFIG_FILE_PATH="/home/dorus/git/obsidian-html/ci/test_vault/config.yml"
REPO_PATH="/home/dorus/git/empty"

# Move into the correct folder
cd $REPO_PATH

# Empty folder
echo "Will delete previous output:"
find . -maxdepth 1 ! -path '.' ! -path "./.git/*" ! -name ".git" ! -name README.md ! -name __src -print0 | xargs -0 -I {} echo "{}"
echo "Continue? (y/n)"
read yn
if [ "$yn" != "y" ]; then
    echo "Aborted"
    exit 0
fi

find . -maxdepth 1 ! -path '.' ! -path "./.git/*" ! -name ".git" ! -name README.md ! -name __src -print0 | xargs -0 -I {} /bin/rm -rf "{}"


# Compile site
obsidianhtml -i $CONFIG_FILE_PATH

git add . --all
git commit -m "autopush"
git push