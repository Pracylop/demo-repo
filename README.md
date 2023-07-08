# Demo

This is a demo of how to use Git. It is created following instructions in the youtube [video](https://www.youtube.com/watch?v=RGOj5yH7evk)

The goal is to demostrate how to use Git and Github, from a beginner's perspective. It will also include links to resources.

## Cloning a Git Repo
The first step towards cloning using Git with an existing repo is to clone it. This is done using the `git clone` command.

Here are the steps to execute the command:
1. Find the project URL from the <>Code dropdown. You can chose HTTPS or SSH. The SSH URL for this project looks like this: `git@github.com:Pracylop/demo-repo.git`
2. Use the following command in a terminal: `git clone git@github.com:Pracylop/demo-repo.git`

## Pushing Changes
In Git-speak, `push` is used to describe the process of saving changes to a remote repository (like Github). This is carried out through 3 sets of commands (i) add, (ii) commit, and (iii) push.

### add
The `add` command is used to setup a file or group of files for saving (or commit in Git-speak). Think of `add` a mechanism for queing up files to be committed. You are basically informing Git, can you please line up these files for saving?

The command can be used in 3 major ways (i) add <FILE_NAME>, (ii) add <FILENAME> <FILENAME>, and (iii) add <PERIOD>

add <FILENAME>
This is used to add a single updated file. The <FILENAME> is a placeholder which is replaced by the actual name of the file. For instance, to add the README.md file, you would type `git add README.md`

add <FILENAME> <FILENAME>
This is used to add multiple updated files. Each <FILENAME> is a placeholder which is replaced by the actual name of the file. You can add as many files as possible For instance, to add the README.md, index.html and styles.css files, you would type `git add README.md index.html styles.css`

add <PERIOD>
This is used to add all updated files. The <PERIOD> is a placeholder which is replaced by the actual period. For instance, to add all updated files, type `git add .`

### commit
The `commit` command is used to save the changes in the local repository. The command has a -m flag which is used to describe the changes. You can use one or two -m flags but must use at least one. Here is an example:

`git add styles.css`
`git commit -m "New layout for homepage"`

### push
The `push` command is used to save the changes in a remote repository. Here is an example of how to use it:
`git add styles.css`
`git commit -m "New layout for homepage"`
`git push`

## Restoring Changes to A File
If you made an edit to a file and would like to restore it to a previous version, use the `restore` command. This is followed by the filename. For isntance, to restore README.md, type:

`git resptore README.md`

## Resources
### Setting up SSH
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
