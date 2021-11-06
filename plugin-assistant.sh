#!/bin/bash

cd $HOME

#vars
read -p 'Path to create new directory in: ' parentPath
read -p 'Enter plugin id: ' pluginID
read -p 'Enter plugin name: ' pluginName
read -p 'Enter plugin description: ' pluginDesc
read -p 'Enter plugin author: ' pluginAuthor
read -p 'Enter the initial version of the plugin: ' pluginStartVersion

echo "✅ Variables set"

gitProfile=`git config user.name`
authorURL="github.com/$gitProfile"
releaseYmlGist="https://gist.github.com/52cf6dcd326743160c29c959bdad7d94.git"

# Create new folder
cd "$parentPath"
mkdir $pluginID && cd $pluginID

echo "✅ Folder created"

# Initialise git repo
git init

# Create new repo on github based on Obsidian's sample plugin
gh repo create $pluginID -y -d "${pluginDesc}" --public -p "https://github.com/obsidianmd/obsidian-sample-plugin"
git pull origin master

echo "✅ Repo created"

# Rename the default branch to main
git checkout -b main origin/master --no-track
git push -u origin main
git remote set-head origin main

# Set default branch
gh api -XPATCH repos/${gitProfile}/${pluginID} -f default_branch=main >/dev/null

# Delete 'master' remotely
git push origin --delete master

echo "✅ Default set to main"

# Change docs
echo "✅ # ${pluginID}" > README.md
echo "✅ Updated readme"

# Find and replace in manifest.json
findStrings=( "obsidian-sample-plugin" "Sample Plugin" 1.0.1 "This is a sample plugin for Obsidian. This plugin demonstrates some of the capabilities of the Obsidian API." "\"author\": \"Obsidian\"" "\"authorURL\": \"obsidian.md\"")
replaceStrings=( $pluginID "$pluginName" $pluginStartVersion "$pluginDesc" "\"author\": \"$pluginAuthor\"" "\"authorURL\": \"$authorURL\"")

for (( n=0; n<${#findStrings[@]}; n++ ))
do
    sed -i "" "s/${findStrings[$n]}/${replaceStrings[$n]}/" manifest.json
done

echo "✅ Changed manifest.json"

# Copy manifest.json to manifest-beta for BRAT
touch manifest-beta.json
cat manifest.json > manifest-beta.json

echo "✅ Changed manifest-beta.json"

# Find and replace in package.json
findStrings=( "obsidian-sample-plugin" "This is a sample plugin for Obsidian (https://obsidian.md)")
replaceStrings=( $pluginID $pluginDesc )

for (( n=0; n<${#findStrings[@]}; n++ ))
do
    sed -i "" "s%${findStrings[$n]}%${replaceStrings[$n]}%" package.json
done

echo "✅ Changed package.json"

# Set up github actions: Clone release.yml from github gist
mkdir -p .github/workflows && cd .github/workflows
gh gist clone $releaseYmlGist

echo "✅ Clones release.yml"

# Add the plugin id in actions
sed -i "" "s/FINDME/$pluginID/" release.yml

# Commit all changes!
cd ../..
git add .
git commit -m "🎉 init"
git push origin main

# Open in browser to verify
gh repo view --web

# Open in VSCode
code .