# Aliases for assuming an AWS role
alias cdr='aws-vault exec cw-dev-read'
alias cdw='aws-vault exec cw-dev-write'
alias cpr='aws-vault exec cw-prod-read'

# Alias for connecting to the Reporting DB - Note: VPN must be active
alias rdb='psql --host reporting-db-dev.clubware-internal.com --dbname reporting-dev --username reporting-fn'

# Clubware commt - Gets ticket ID from current Git branch and creates a commit that prefixes the commit message with ticket ID
# Usage: `cwc Do the thing`
cwc() {
  TICKET_ID=$(git rev-parse --abbrev-ref HEAD | \grep -Eo "CRMWEB-[0-9]{4}")
  git commit -m "[$TICKET_ID] $1"
}
