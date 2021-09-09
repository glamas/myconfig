# cmder/comenu task
# msys2
# set CHERE_INVOKING=1 & set MSYS2_PATH_TYPE=inherit & set "msys64bin=D:\Portable\msys64\usr\bin" & set "PATH=%PATH%;%msys64bin%" & %msys64bin%\bash.exe --login -i
# git
# set "PATH=D:\Portable\Git\usr\bin;%PATH%" & D:\Portable\Git\git-cmd.exe --no-cd --command=%ConEmuBaseDirShort%\conemu-msys2-64.exe /usr/bin/bash.exe -l -i -new_console:p

function cascade_add_path {
	ORIGIN_CYGPATH=$(where cygpath)
	flag=0
	path_before=""
	path_after=""
	arr=($1)
	for path in ${arr[*]}; do
		if [[ ${path} == "" ]];then
			continue
		fi
		if [[ ${path} == "------" ]];then
			flag=1
			continue
		fi
		path=$($ORIGIN_CYGPATH -u ${path})
		for file in `ls ${path}`;
		do
			# add top/subdir/{bin, sbin}
			if [ -d "${path}/$file" ]; then
				if [[ ${flag} == 0 ]]; then
					path_before=$path_before:${path}/$file
				else
					path_after=$path_after:${path}/$file
				fi
				if [ -d "${path}/$file/bin" ]; then
					if [[ ${flag} == 0 ]]; then
						path_before=$path_before:${path}/${file}/bin
					else
						path_after=$path_after:${path}/${file}/bin
					fi
				fi
			fi
		done
		# add top/{bin,sbin}
		if [ -d "${path}/bin" ]; then
			if [[ ${flag} == 0 ]]; then
				path_before=$path_before:${path}/bin
			else
				path_after=$path_after:${path}/bin
			fi
		fi
		if [ -d "${path}/sbin" ]; then
			if [[ ${flag} == 0 ]]; then
				path_before=$path_before:${path}/sbin
			else
				path_after=$path_after:${path}/sbin
			fi
		fi
		# add top path
		path_before=$path_before:${path}
	done
	if [[ $path_before != "" ]]; then
		PATH=$path_before:$PATH
	fi
	if [[ $path_after != "" ]]; then
		PATH=$PATH:$path_after
	fi
	export PATH
}

# ENV var
HOME="${CMDER_ROOT}/home"
HISTFILE="${HOME}/.bash_history"
export TERMINFO=/usr/share/terminfo

# PATH
# add manual path
CUSTOME_PATH=(
"${CMDER_ROOT}/bin"
"------"    # <-- origin PATH here
)
cascade_add_path "${CUSTOME_PATH[*]}"

. ${HOME}/.bashrc
echo "done"
