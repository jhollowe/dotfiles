# jhollowe's Dot Files

Config files for applications are often in the user's home directory with names starting with a "." which be default hides the files.

These dotfiles are managed under version control using Git using the instructions below.

## Installation

To install these dotfiles, start with the following commands

```shell
git clone --bare https://github.com/jhollowe/dotfiles ~/.dotfiles/
alias dotcfg='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

To completely overwrite your existing dotfiles, run the following:
```shell
dotcfg reset --hard HEAD
```
To save a copy of the existing dotfiles, run the following (These files can be restored with `git stash apply`.):
```shell
dotcfg stash push -m "Save existing dotfiles"
```


## Addition


Setup inspired by [this Atlassian tutorial](https://web.archive.org/web/20211228210451/https://www.atlassian.com/git/tutorials/dotfiles)
