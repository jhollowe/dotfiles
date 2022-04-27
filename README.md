# jhollowe's Dot Files

Config files for applications are often in the user's home directory with names starting with a "." which be default hides the files.

These dotfiles are managed under version control using Git using the instructions below.

## Installation

To install these dotfiles, start with the following commands

```shell
git clone --bare https://github.com/jhollowe/dot-files ~/.dotfiles/
alias dotcfg='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

to completely overwrite your existing dotfiles, run `dotcfg reset --hard HEAD`. To save a copy of the existing dotfiles, use `dotcfg stash push -m "Save existing dotfiles"`. These files can be restored with `git stash apply`.


## Addition


Setup inspired by [this Atlassian tutorial](https://web.archive.org/web/20211228210451/https://www.atlassian.com/git/tutorials/dotfiles)
