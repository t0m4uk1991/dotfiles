function init_git_bash_prompt() {
      source ~/.bash-git-prompt/gitprompt.sh
      GIT_PROMPT_ONLY_IN_REPO=0
}

function invitation() {
    clear
    echo -ne "${LIGHTGREEN}" "Hello, $USER. today is, "; date
    echo -e "${WHITE}"; cal ;  
    echo -ne "${CYAN}";
    echo -ne "${LIGHTPURPLE}Sysinfo:";uptime ;echo ""
}

function check_assignet_to_me_tasks() {
    JIRA_LOGIN=""
    JIRA_PASSWORD=""
    JIRA_HOST=""
    JIRA_REQUEST_PATH="$JIRA_HOST/rest/api/2/search?jql=assignee=$JIRA_LOGIN%20AND%20status%20in%20(%27open%27,%20%27in%20progress%27,%27doing%27)&fields=key,status,issuetype,summary,priority"
    JQ_STRING=".issues[] | [.key, .fields.priority.name, .fields.status.name, .fields.summary]|join(\",\")"
    AWK_OUTPUT_FORMAT_STRING='{ gsub("\"",""); printf "%-10s %-6s %-12s %-20s \n", $1, $2, $3, $4}'

    DAY_OF_WEEK=$(date +%u)
    CURRENT_HOUR=$(date +"%H")

    if [[ "$DAY_OF_WEEK" -lt 6 && "$CURRENT_HOUR" -gt 9 && "$CURRENT_HOUR" -lt 18 ]]
    then
        JIRA_RESPONCE=$(curl -u "$JIRA_LOGIN":"$JIRA_PASSWORD" -X GET -s -H "Content-Type: application/json" "$JIRA_REQUEST_PATH")
        SELECTED_TICKETS=$(echo $JIRA_RESPONCE | jq "$JQ_STRING" | awk -F "," "$AWK_OUTPUT_FORMAT_STRING")
        echo "$SELECTED_TICKETS"
    fi
}

init_git_bash_prompt
invitation
check_assignet_to_me_tasks