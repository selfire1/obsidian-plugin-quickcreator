# Quick Creator for Obsidian Plugins ⚡️
This is a bash script that makes creating new plugins quick and easy. 

Start the script, add your details and a new plugin repo based on [obsidianmd/obsidian-sample-plugin](https://github.com/obsidianmd/obsidian-sample-plugin) gets created with all your details. Bob's your uncle!

## Requirements
1. Install `github cli` via [brew](https://brew.sh/) – `brew install gh`
2. Set up [Automatically Open the Current Directory in VS Code From Terminal](https://shannoncrabill.com/blog/shell-command-open-directory-in-vscode/) (it's pretty straight-forward)

## All set up ready to go
### Core
Here is the core of what gets created:
* ✅ New folder based on `obsidian-sample-plugin`
* ✅ Github repo connected to that folder
* ✅ Updated description, id, name and author in `manifest.json` and `package.json`

### Specifics
These specific things get set up as well. Your mileage may vary, simply modify the script.
* ☑️ Updated default branch to `main`
* ☑️ Created `manifest-beta.json` for use with [BRAT](https://github.com/TfTHacker/obsidian42-brat)
* ☑️ Creates `.github/workflows/release.yml` for easy [Release of plugin with GitHub Actions](https://marcus.se.net/obsidian-plugin-docs/publishing/release-your-plugin-with-github-actions)

Of course, all of these files are set up with all of your details.

### Automation
Moreover, some more automation happens.
* ✔️ Commit all changed files
* ✔️ Open repo on github to verify
* ✔️ Open working folder in VS Code to get started developing!

## Support
You can help me keep creating tools like this by [buying me a coffee](https://www.buymeacoffee.com/joschua).  ☕️

<a href="https://www.buymeacoffee.com/joschua" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height= "48" width="173"></a>


