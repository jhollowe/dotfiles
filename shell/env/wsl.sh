# if starting WSL bash from the default location, cd to home.
# if a custom location is set, leave it there
if [ ${PWD^^} == "/MNT/C/WINDOWS/SYSTEM32" ]; then
  cd ~
fi
