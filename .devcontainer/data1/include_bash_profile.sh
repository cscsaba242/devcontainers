export HISTSIZE=300
export HISTFILESIZE=300
export TAR_BACKUP_OPTION="--exclude-backups --files-from=tar_files_from.txt --show-omitted-dirs"
checkDirs $_BACKUP $_BASH_HOME "$_ONE_DRIVE"
# ..................
declare -A cmap

cmap["red"]="31"
cmap["green"]="32"
cmap["yellow"]="33"
cmap["magenta"]="35"
cmap["blue"]="34"
cmap["cyan"]="36"

shopt -s globstar # enable ** globbing
BEEP=b1

alias myvim=$BACKUP"/myvim/vim.sh"
alias setproxy=setproxyfunc # set proxy [0|1|2|3|4|5|6]
alias s='source ~/.bash_profile' # reload bash profile
alias checkurl='checkurlfunc' # check url via multiple proxies
alias bck='bckfunc'
alias bckKeePass='bckKeePassfunc'
alias idea="$IDEA_HOME/bin/idea &" 
alias tomp3="tomp3func" # convert mkv to mp3
alias bsh="echo 'Loaded from: ${BASH_SOURCE[0]}'"
alias senv="export -p | egrep ' _[A-Z]'" # show only custom env.vars with _ prefix
alias g="./gradlew "
alias grep="grep --color=auto 2>/dev/null";
alias ls="ls -al";
alias lsusers="cut -d: -f1 /etc/passwd"
alias gitlog="gitlogfunc";
alias gitlog5="gitlog5func";
alias gitlog10="gitlog10func";
alias gs="git status";
alias gittag="git log --tags --simplify-by-decoration --pretty='format:%ai %d'";
alias gitfindchange="gitfindchangefunc"
alias gitbranchage="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
alias finddups="finddupsfunc"
alias lb="lbfunc"
alias lbtmux="lbtmuxfunc";
alias wtkp="wtkpfunc"
alias findrw="find . -not -perm a+rw >/dev/null";
alias findx="find . -perm a+x -type d >/dev/null";
alias flog="find . -iname "*.log" -type f >/dev/null";
alias upvs="upvsfunc";
alias polln="pollnfunc";
alias sb="sbfunc";
alias tmuxvh="tmuxvhfunc";
alias l='ls --color -lhF --group-directories-first'
alias robot=robotfunc
alias findde=finddefunc
alias diffab=diffabfunc
alias awscp=awscpfunc
alias pmddup=pmddupfunc
alias tag=tagfunc
alias german=germanfunc

# containers
alias dc='docker compose ' # docker compose detached
alias d='docker ' # docker
alias k="kubectl";
alias kwp="watch -d kubectl get pod";
alias kwl="kwlfunc";
alias kdeletep="kdeletepfunc";
alias kgcj="kgcjfunc";
alias kep="kepfunc";
alias kwo="kwofunc";
alias kd="kubectl delete pods,jobs,cronjobs -all";
alias kdall="kubectl delete all -all";
alias hsr="helm search repo";
# ..................

export DOCKER_HOST=unix:///var/run/docker.sock
export PROXY1="http://he202194.emea2.cds.t-internal.com:3128"
export PROXY2="http://ibinproxy01.itsh.itsh-internal.hu:3128"
export PROXY3="http://ibinproxy01.itsh.itsh-internal.hu/proxy_emea2.pac"
export PROXY4="http://tudas-proxy.rd.hu.t-internal.com:3128"
export PROXY5="http://sia-lb.telekom.de:8080"
export PROXY6="http://localhost:8080"

# source $HOME/.sdkman/bin/sdkman-init.sh

updatePrompt() {
	base="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \[\]"
	export PS1="${HTTP_PROXY:7:12} ${BASH_HOME:0:5}> "$base
}

setproxyfunc() {
        echo "[0|1|2|3|4|5|6]"
        echo "0 NO PROXY"
        echo "1" $PROXY1
        echo "2" $PROXY2
        echo "3" $PROXY3
        echo "4" $PROXY4
        echo "5" $PROXY5
        echo "6" $PROXY6

        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset JAVA_TOOL_OPTIONS

        selected=""

        if [ "$1" = "1" ]; then
                selected="$PROXY1"
        elif [ "$1" = "0" ]; then
                updatePrompt
                echo "unset proxy settings like HTTP_PROXY, HTTPS_PROXY, JAVA_TOOL_OPTIONS"
                return
        elif [ "$1" = "2" ]; then
                selected="$PROXY2"
        elif [ "$1" = "3" ]; then
                selected="$PROXY3"
        elif [ "$1" = "4" ]; then
                selected="$PROXY4"
        elif [ "$1" = "5" ]; then
                selected="$PROXY5"
        elif [ "$1" = "6" ]; then
                selected="$PROXY6"
        fi

        echo "SELECTED:" $selected

        export HTTP_PROXY=$selected
        export HTTPS_PROXY=$selected
        export NO_PROXY="localhost,127.0.0.1"

        proxyToJavaOptions $selected

        echo "HTTP_PROXY:" $HTTP_PROXY
        echo "HTTPS_PROXY:" $HTTPS_PROXY
        echo "JAVA_TOOL_OPTIONS:" ${JAVA_TOOL_OPTIONS:0:20}
        updatePrompt
}

# ctext "cyan" "hello"
function ctext() {
    echo -e "\033[${cmap[$1]}m ${2}\033[0m"
}

logoutfunc() {
    "$@" 2> >(tee -a ~/logout.log >&2)
}


function checkurlfunc() {
local proxies=(
		http://he2021z94.emea2.cds.t-internal.com:3128
		http://ibinproxy01.itsh.itsh-internal.hu:3128
		http://tudas-proxy.rd.hu.t-internal.com:3128
     	http://sia-lb.telekom.de:8080
    );
 
local dnss=(
    10.232.127.10
    #10.232.118.7
    10.33.255.23
    #10.34.255.23
    #8.8.8.8
    #4.4.4.4
)
 
        ctext red "Testing ${1} via proxies:"
        for proxy in ${proxies[@]}                                                                                                                                                                                                
        do
            export HTTP_PROXY=$proxy
            export HTTPS_PROXY=$proxy
 
            ctext green "proxy: ${proxy} ";
            #resp_code=$(curl -o /dev/null -s -w "%{http_code}" -x $proxy $1)
            #echo "curl response code:"$resp_code
            curl -s --proxy $proxy --head --connect-timeout 2 $nohttp > /dev/null 2>&1 && echo "curl:ok" || echo "curl:nok"
 
            nohttp=$(echo ${1} | sed -E 's|https?://||')

            #echo $pingresp | grep  -oh ",.*%.*packet .*,"
            nslookup $nohttp > /dev/null 2>&1 && echo "nslookup:ok" || echo "nslookup:nok"
            for dns in ${dnss[@]}
            do
                dig @$dns $nohttp > /dev/null 2>&1 && echo "dig ${dns} :ok" || echo "dig ${dns}:nok"
            done
        done
}

bckKeePassfunc() {
  ctext cyan "bckKeePass to OneDrive, started."
  checkEnvVars _BASH_HOME _ONE_DRIVE _PART
  checkDirs "${_ONE_DRIVE}/BackupCorp" "${_BASH_HOME}"

  cd ${_BASH_HOME}

	local timestamp=$(date +%Y%m%d)
  local babes=${_BASH_HOME}/backup/babes_latest.arj
  local cars=${_BASH_HOME}/backup/cars_latest.arj

  if [ -e $babes ]; then
    ctext "bck, moving babes to OneDrive"
    cp $babes "${_ONE_DRIVE}/BackupCorp"
    cp $babes "${_ONE_DRIVE}/BackupCorp/babes_latest_${timestamp}.arj"
  else 
    ctext "bck, cant find: $babes" 
  fi

  # cars
  local cars=${_BASH_HOME}/backup/cars_latest.arj 
  if [ -e $cars ]; then
    ctext "bck, moving cars to OneDrive"
    cp ${_BASH_HOME}/backup/cars_latest.arj "${_ONE_DRIVE}/BackupCorp"
    cp ${_BASH_HOME}/backup/cars_latest.arj "${_ONE_DRIVE}/BackupCorp/car_latest_${timestamp}.arj"
  else
    ctext "bck, cant find: $cars"
  fi

  ls -ltr "${_ONE_DRIVE}/BackupCorp"
}

bckfunc() {
  echo "bck to OneDrive, started."
  checkEnvVars _BASH_HOME _ONE_DRIVE _PART
  checkDirs "${_ONE_DRIVE}/BackupCorp" "${_BASH_HOME}"
  checkFiles "${_BASH_HOME}/tar_files_from.txt"

  cd ${_BASH_HOME}
	local timestamp=$(date +%Y%m%d)
	local backup_name="itsh_${_PART}_backup_${timestamp}.tar.gz~"

	tar -czvf $backup_name $TAR_BACKUP_OPTION 
	
	mv $backup_name "${_ONE_DRIVE}/BackupCorp"
  ls -ltr "${_ONE_DRIVE}/BackupCorp" | tail -n 3
  tar -tvf "${_ONE_DRIVE}/BackupCorp/${backup_name}"
}

proxyToJavaOptions() {
        unset JAVA_TOOL_OPTIONS 
        IFS=':' read -ra parts <<< "$1" # split string into array based on ':'

        if [ ${#parts[@]} -eq 3 ]; then
                http=${parts[1]}
                http_=$(echo $http | sed 's"//""g') 
                port="${parts[2]}"
                JAVA_OPTIONS="-Dhttp.proxyHost=$http_ -Dhttp.proxyPort=$port "
                JAVA_OPTIONS=$JAVA_OPTIONS" -Dhttps.proxyHost=$http_ -Dhttps.proxyPort=$port "
                JAVA_OPTIONS=$JAVA_OPTIONS" -Dhttp.nonProxyHosts="$NO_PROXY
                export JAVA_TOOL_OPTIONS=$JAVA_OPTIONS
                JAVA_OPTIONS=""

        elif [ ${#parts[@]} -eq 2 ]; then
                http=${parts[1]}
                http_=$(echo $http | sed 's"//""g')
                JAVA_OPTIONS=$JAVA_OPTIONS" -Dhttp.proxyHost=$http_ "
                JAVA_OPTIONS=$JAVA_OPTIONS" -Dhttps.proxyHost=$http_ "
                JAVA_OPTIONS=$JAVA_OPTIONS" -Dhttp.nonProxyHosts="$NO_PROXY
                export JAVA_TOOL_OPTIONS=$JAVA_OPTIONS
                JAVA_OPTIONS=""
        else
                echo "Invalid proxy format"
                exit 1
        fi
}

updatePrompt

function tomp3func() {
# Input directory containing MKV files
input_dir="."

# Output directory for MP3 files
output_dir="."

# Iterate over each MKV file in the input directory
for mfile in "$input_dir"/*.$1; do
    # Extract the file name without extension
    filename=$(basename "$mfile" .$1)

    # Construct the output file path
    output_file="$output_dir/$filename.mp3"

    # Run ffmpeg to convert the MKV file to MP3
    ffmpeg -y -i "$mfile" -vn -acodec libmp3lame -aq 0 "$output_file"
done
}

checkEnvVars() {
  for param in "$@"; do
    if [[ -z "${!param+x}" ]]; then
      ctext red "Error, env.var "$param", doesnt exist."
      trap ''
    fi
    # ctext green "Info, env.var "$param", exists."
  done
}

checkFiles() {
  for param in "$@"; do
    if [[ ! -f "$param" ]]; then
      ctext red "Error, file \"$param\", doesnt exist."
      trap '';
    fi
    # ctext green "Info, file \"$param\", exists."
  done
}

checkDirs() {
  for param in "$@"; do
    if [[ ! -d "$param" ]]; then
      ctext red "Error, directory \"$param\", doesnt exist."
      trap '';
    fi
    # ctext green "Info, directory \"$param\", exists."
  done
}

tomp3func() {
# Input directory containing MKV files
input_dir="."

# Output directory for MP3 files
output_dir="."

# Iterate over each MKV file in the input directory
for mfile in "$input_dir"/*.$1; do
    # Extract the file name without extension
    filename=$(basename "$mfile" .$1)

    # Construct the output file path
    output_file="$output_dir/$filename.mp3"

    # Run ffmpeg to convert the MKV file to MP3
    ffmpeg -y -i "$mfile" -vn -acodec libmp3lame -b:a 320k -aq 0 "$output_file"
done
}

gitfindchangefunc() {
  ctext cyan "git find change $2 in file $1, started."
	file = $1
	pattern = $2
	git log -p $file | grep ".* ${pattern}" -B 3
}

finddupsfunc() {
  ctext cyan "finddups with min.tokens $1, started."
	checkDirs ${JAVA_HOME}/bin;
	pmd cpd --minimum-tokens $1 'C:\Users\A86831600\dups.txt'
}

# git tag function
tagfunc() {
	echo "git [1:l|lr] [2:list|delete|update|fetch] 3:tagname 4:commitid 5:-m 'comment'"
		
	if [ "$1" = "l" ]; then
			case "$2" in
			  list)
					read -p "listing local tags ?" answer
					if [ "$answer" = "y" ]; then
						git tag
					fi
			  ;;
			  delete)
				read -p "delete local tag $3 ? (y/n)" answer
					if [ "$answer" -eq "y" ]; then
					git tag -d $3
					fi
				;;
			  create)
				read -p "crate tag $3 ? (y/n)" answer
					if [ "$answer" -eq "y" ]; then
						git tag $3 
					fi		
				;;
			  fetch)
				read -p "fetch tag $3 from remote ? (y/n)" answer
					if [ "$answer" = "y" ]; then					
						git fetch origin tag $3
					fi		
				;;				
			  *)
			esac
	fi
	if [ "$1" = "lr" ]; then
			case "$2" in
			  list)
				read -p "listing local remote tags (y/n)" answer
					if [ "$answer" = "y" ]; then
						git tag
						git ls-remote --tags origin
					fi
			  ;;
			  delete)
				read -p "delete locally and remotely tag $3 ? (y/n)" answer
					if [ "$answer" = "y" ]; then
						git tag -d $3
						git push origin --delete $3
					fi
				;;
			  create)
				read -p "crate tag locally and remotely $3 ? (y/n)" answer
					if [ "$answer" = "y" ]; then					
						git tag $3
						git push --tags origin
					fi		
				;;
			  *)
			esac
	fi	
}

gitchangefunc() {
	echo $1 file name
	echo $2 what is missing

	git log -p $1 | grep $2 -B 3
}
#tig log for last days in new tmux window
tiglogbfunc() {
		tmux new-window;
		tmux select-pane -t 0;
		tmux send-keys -t 0 "cdlogb; tig develop --after=`date +%Y-%m-%d -d "60 day ago"`" Enter
}

tmuxvhfunc() {
	tmux new-window;

	for (( c=1; c<$1; c++ ))
	do
		if [ "$2" = "v" ]; then
			tmux splitw -v;
		fi
		if [ "$2" = "h" ]; then
			tmux splitw -h;
		fi
	done

	if [ "$2" = "h" ]; then
		tmux select-layout even-vertical
	fi
	if [ "$2" = "v" ]; then
		tmux select-layout even-horizontal
	fi

	tmux select-pane -t 0;
}

beepfunc() {
	if [ -z "$1" ]
	then
		cat ${_BASH_HOME}/b1.wav > /dev/dsp;
	else
		cat ${_BASH_HOME}/b$1.wav > /dev/dsp;
	fi
}

wtkpfunc() {
 netstat -aon | grep ":$1" | grep -oh "LISTENING *[0-9]*" | grep -oh "[0-9]*" | head -1 | xargs taskkill /F /PID
}

gitlogfunc() {
	echo "git pretty log since : $1 count of logs, $2 since e.g 07/08"
	git log --pretty="%H %an %ad %s " --since=$2 -n $1
}

gitlog5func() {
	git log -n 5 --pretty="%h %s %an %ad "
}

gitlog10func() {
	git log -n 10 --pretty="%h %s %an %ad "
}

kwofunc() {
	watch -d kubectl get services,pods,jobs,cronjobs
}

kepfunc() {
 # open the bashp prompt on pod $1
 kubectl exec --stdin --tty $1 -- /bin/bash;
}

kgcjfunc() {
 kubectl get cronjob *;
}

kdeletepfunc() {
	kubectl delete pod $1;
}

kwlfunc() {
	# watching log of $1 pod
	watch -d kubectl logs $1;
}

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function upvsfunc() {
  if $_PART != "cygwin" ; then
    echo "upvsfunc is only for cygwin env."
    return
  fi

  
	downdir="/cygdrive/c/Users/A86831600/Downloads"
	destdir="/cygdrive/c/Users/A86831600/PortableApps/VSCode11"

    checkDirs $destdir $downdir

	ls ${downdir}/VSCode-win32*.zip
	echo "-----------------"
	test ${destdir}; echo $?
	read -p  "check the source zip and target dir availability"

  # rename the downloaded zip
	mv ${downdir}/VSCode-win32*.zip ${downdir}/VSCode.zip

	if [ -f ${downdir}/VSCode.zip ]; then
    # remover old files
		rm -rf ${destdir}/*
    # unizip into the destdir
		unzip ${downdir}/VSCode.zip -d ${destdir}
    # remove the zip
		rm -rf ${downdir}/VSCode.zip
    # set rwx permissions
		find ${destdir} -type f -exec chmod a+rwx {} +
	else
		echo ${downdir}/VSCode.zip doesnt exists
	fi
}

function updbvfunc() {
  if $_PART != "cygwin" ; then
    echo "updbvfunc is only for cygwin env."
    return
  fi

  checkDirs /cygdrive/c/Users/A86831600/Apps/dbeaver /cygdrive/c/Users/A86831600/Downloads

	downdir=/cygdrive/c/Users/A86831600/Downloads
	destdir=/cygdrive/c/Users/A86831600/Apps

	ls ${downdir}/dbeaver-ce*.zip
	mv ${downdir}/dbeaver-ce*.zip ${downdir}/dbeaver.zip

	if [ -f ${downdir}/dbeaver.zip ]; then
		rm -rf ${destdir}/dbeaver/*
		unzip ${downdir}/dbeaver.zip -d ${destdir}
		rm -rf ${downdir}/dbeaver.zip
		find ${destdir}/dbeaver -type f -exec chmod a+rwx {} +
	else
		echo ${downdir}'/dbeaver.zip doesnt exists'
	fi

}

function upkpassfunc() {
  if $_PART != "cygwin" ; then
    echo "upkpassfunc is only for cygwin env."
    return
  fi

  checkDirs /cygdrive/c/Users/A86831600/Apps/KeePass /cygdrive/c/Users/A86831600/Downloads

	downdir=/cygdrive/c/Users/A86831600/Downloads
	destdir=/cygdrive/c/Users/A86831600/Apps/KeePass

	ls ${downdir}/KeePass-*.zip
	mv ${downdir}/KeePass-*.zip ${downdir}/KeePass.zip

	if [ -f ${downdir}/KeePass.zip ]; then
		rm -rf ${destdir}/*
		unzip ${downdir}/KeePass.zip -d ${destdir}
		rm -rf ${downdir}/KeePass.zip
		find ${destdir} -type f -exec chmod a+rwx {} +
	else
		echo ${downdir}'/KeePass.zip doesnt exists'
	fi
}

function killpids() {
if $_PART != "cygwin" ; then
    echo "killpids is only for cygwin env."
    return
fi

readarray -d : -t PIDSARRAY <<<"$PIDS";
for((n=1; n < ${#PIDSARRAY[*]};n++))
	do
		taskkill /PID ${PIDSARRAY[n]}
	done
export PIDS=
}

logcmd() {
  # clear the content of last.log
  local timestamp=$(date +%Y%m%d_%H%M%S)
  mv last.log last_$timestamp.log 2>/dev/null
  > last.log
  # Print the last command from history to the log file
  echo "THIS TEXT BELOW SHOWS THE 'COMMAND' AND ITS 'OUTPUT'" >> last.log 
  echo "COMMAND: " >> last.log
  echo "$(history 1 | sed 's/^[ ]*[0-9]\+[ ]*//' | sed -E 's/(logcmd|Picked up JAVA_TOOL_OPTIONS)//')" | tee -a "last.log"
  # Read stdin and log output
  echo "OUTPUT: " >> last.log
  "$@" 2> >(tee -a last.log >&2)
}