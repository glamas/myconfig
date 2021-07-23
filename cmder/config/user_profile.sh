# cmder/comenu task
# msys2
# set CHERE_INVOKING=1 & set MSYS2_PATH_TYPE=inherit & set "msys64bin=D:\Portable\msys64\usr\bin" & set "PATH=%PATH%;%msys64bin%" & %ConEmuBaseDirShort%\conemu-msys2-64.exe -new_console:p %msys64bin%\bash.exe --login -i
# git
# set "PATH=D:\Portable\Git\usr\bin;%PATH%" & D:\Portable\Git\git-cmd.exe --no-cd --command=%ConEmuBaseDirShort%\conemu-msys2-64.exe /usr/bin/bash.exe -l -i -new_console:p

function cascade_add_path {
	if [[ $1 == "" ]];then
		return
	fi
	path=$(cygpath -u $1)
	for file in `ls ${1}`;
	do
		# add top/subdir/{bin, sbin}
		if [ -d "${path}/$file" ]; then
			PATH=$PATH:${path}/$file
			if [ -d "${path}/$file/bin" ]; then
				PATH=$PATH:${path}/${file}/bin
			fi
		fi
	done
	# add top/{bin,sbin}
	if [ -d "${path}/bin" ]; then
		PATH=$PATH:${path}/bin
	fi
	if [ -d "${path}/sbin" ]; then
		PATH=$PATH:${path}/sbin
	fi
	# add top path
	export PATH=$PATH:${path}
}

# ENV var
HOME="${CMDER_ROOT}/home"
HISTFILE="${HOME}/.bash_history"

# PATH
# add manual path
CUSTOME_PATH=(
"${CMDER_ROOT}/bin"
)
for ((i=0; i<${#CUSTOME_PATH[*]}; i++))
do
	cascade_add_path ${CUSTOME_PATH[i]}
done

echo "done"
