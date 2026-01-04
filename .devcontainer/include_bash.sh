
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