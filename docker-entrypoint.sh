#!/bin/bash
set -e

create_config() {
	cat <<-EOF >/cpuminer/miner.conf
	{
		"host": "${HOST}",
		"port": "${PORT}",
		"nxs_address": "${ADDRESS}",
		"sieve_threads": ${SIEVE_THREADS},
		"ptest_threads": ${PTEST_THREADS},
		"timeout": ${TIMEOUT},
		"bit_array_size": ${BIT_ARRAY_SIZE},
		"prime_limit": ${PRIME_LIMIT},
		"n_prime_limit": ${N_PRIME_LIMIT},
		"primorial_end_prime": ${PRIMORIAL_END_PRIME},
		"experimental": "${EXPERIMENTAL}"
	}
	EOF
	echo "Using the following config."
	cat /cpuminer/miner.conf
}

# PrimePoolMiner entrypoint.
if [[ "${1}" =~ ^(bash|sh)$ ]]; then
	exec "${@}"
elif [[ ${#} -gt 1 ]]; then
	# Pass along any CMD arguments.
	create_config
	exec /usr/local/bin/nexus_cpuminer "${@}"
else
	# For simplicity we will consider a single argument to be an address.
	ADDRESS="${1:-$ADDRESS}"
	create_config
	exec /usr/local/bin/nexus_cpuminer
fi
echo "Exit(${?})"
exit $?
