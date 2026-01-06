
export PROXY_PORT=8888
export GRADLE_OPTS=""

alias g="./gradlew"
alias ns="netstat -tulnp"
alias ss="ss -tulnp"
alias tcpdumpf="tcpdump | tail -n 40"
alias s="source ~/.bashrc"

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

setproxy() {
  export HTTP_PROXY="http://127.0.0.1:${PROXY_PORT}"
  export HTTPS_PROXY="http://127.0.0.1:${PROXY_PORT}"
  unset NO_PROXY
  export JAVA_TOOL_OPTIONS="-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=${PROXY_PORT} -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=${PROXY_PORT} -DnonProxy="
  echo "Proxies set to 127.0.0.1:${PROXY_PORT}"
}

unsetproxy() {
  export HTTP_PROXY="http://tudas-proxy.rd.hu.t-internal.com:3128"
  export HTTPS_PROXY="http://tudas-proxy.rd.hu.t-internal.com:3128"
  export JAVA_TOOL_OPTIONS="-Dhttp.proxyHost=tudas-proxy.rd.hu.t-internal.com -Dhttp.proxyPort=3128 -Dhttps.proxyHost=tudas-proxy.rd.hu.t-internal.com -Dhttps.proxyPort=3128 -DnonProxy="
  unset NO_PROXY
  echo "Proxies set to tudas-proxy.rd.hu.t-internal.com:3128"
}
