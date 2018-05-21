##
## Get SSH Servers list.

[ -f "$SSH_CONFIG_PATH" ] && \
  grep -E '^Host\s+[a-zA-Z0-9]' "$SSH_CONFIG_PATH" | sed -E 's/Host\s+//g' | sort -k9,9
