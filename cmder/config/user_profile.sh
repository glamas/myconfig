# use this file to run your own startup commands for msys2 bash'

# To add a new vendor to the path, do something like:
# export PATH=${CMDER_ROOT}/vendor/whatever:${PATH}

# Uncomment this to have the ssh agent load with the first bash terminal
# . "${CMDER_ROOT}/vendor/lib/start-ssh-agent.sh"

HOME="${CMDER_ROOT}/home"
HISTFILE="${HOME}/.bash_history"
#PATH=${PATH}:${CMDER_ROOT}/bin/python37
. $HOME/.bashrc

export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
# add $CMDER_ROOT/bin to path
for file in `ls ${CMDER_ROOT}/bin`;
do
	if [ -d "${CMDER_ROOT}/bin/$file" ]; then
		PATH=${CMDER_ROOT}/bin/$file:$PATH
		if [ -d "${CMDER_ROOT}/bin/$file/bin" ]; then
			PATH=${CMDER_ROOT}/bin/$file/bin:$PATH
		fi
	fi
done
export PATH=${CMDER_ROOT}/bin:$PATH
