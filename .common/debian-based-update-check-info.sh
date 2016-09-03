UPDATE_ENTRYPOINT=/bin/bash
UPDATE_COMMAND="-c 'apt-get update >/dev/null && apt-get --dry-run dist-upgrade | grep -F Inst | wc -l | tr -d [[:space:]]'"
