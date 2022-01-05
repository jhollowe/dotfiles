# jhollowe's Dot Files

Config files for applications are often in the user's home directory with names starting with a "." which be default hides the files.

These dotfiles are managed under version control using Git using the instructions below.

## Installation

To install these dotfiles, start with the following commands

```shell
git clone --bare https://github.com/jhollowe/dot-files ~/.dotfiles/
alias dotcfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

to completely overwrite your existing dotfiles, run `dotcfg reset --hard HEAD`. To leave existing files in place, use `dotcfg reset --mixed HEAD`.


## Addition


Setup inspired by [this Atlassian tutorial](https://web.archive.org/web/20211228210451/https://www.atlassian.com/git/tutorials/dotfiles)
