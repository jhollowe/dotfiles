# queries certain attributes of the system and runs commands for specific environments

# cd to the directory of the script, not whatever the PWD was
cd "${0%/*}"

# WSL
if [[ grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ]]; then
	source wsl
	return
fi

# docker container
if [ grep -qa docker /proc/1/cgroup && -f docker ]; then
	source docker
	return # return so generic container is not loaded
fi

# generic container
if [ sudo grep -qa lxc /proc/1/environ && -f container ]; then
	source container
	return
fi
