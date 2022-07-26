#!/bin/bash
# Copyright 2016-2018 Stuart Shelton
# Distributed under the terms of the GNU General Public License v2

declare verbose="${VERBOSE:-1}"
declare trace="${TRACE:-0}"

# Edit the list below to specify those services which should be restarted on
# failure, rather than only generating an alert:
declare -a rc_monitor_restart=(
	apache
	dovecot
	mysql
	opendkim
	postfix
	postgres
)

einfo="echo"
ewarn="echo"
eerror="echo"
ebegin="echo"
eend=":"

if [[ -r /lib/rc/sh/functions.sh ]]; then
	# shellcheck disable=SC1091
	source /lib/rc/sh/functions.sh
	# Sets 'RC_GOT_FUNCTIONS="yes"'
	einfo="einfo"
	ewarn="einfo"
	eerror="eerror"
	ebegin="ebegin"
	eend="eend"
fi

# We don't warn on unbound variables before now as stock OpenRC functions.sh
# has two such cases in it, as of sys-apps/openrc-0.19.1 :(
#
set -u

if grep -Eq -- ' -(q|-quiet) ' <<<" ${*:-} "; then
	EINFO_QUIET=yes
fi
if yesno "${EINFO_QUIET:-}"; then
	verbose=0
fi

quiet=""
(( verbose )) && quiet="--quiet"

if (( EUID )); then
	if [[ -n "${RC_GOT_FUNCTIONS:-}" ]]; then
		eerror "Please execute $( basename "${0:-}" ) as UID 0"
	else
		echo >&2 "FATAL: Please execute $( basename "${0:-}" ) as UID 0"
	fi
	exit 1
fi

if grep -Eq -- ' -(h|-help) ' <<<" ${*:-} "; then
	echo "Usage: $( basename "${0:-}" ) [--quiet] [-- service_to_restart[,...]]"
	exit 0
fi

(( trace )) && set -o xtrace

if grep -Eq -- ' -- ' <<<" ${*:-} "; then
	while [[ -n "${1:-}" ]]; do
		case "${1}" in
			--)
				shift
				break
				;;
			*)
				shift
				;;
		esac
	done
	if [[ -n "${*:-}" && -n "${*// }" ]]; then
		if grep -q -- ' default ' <<<" ${*} "; then
			for item in "${@}"; do
				[[ -n "${item:-}" && "${item:-}" != "default" ]] && 
					! grep -q -- " ${item} " <<<" ${rc_monitor_restart[*]:-} " &&
					rc_monitor_restart+=( "${item}" )
			done
		else
			rc_monitor_restart=( "${@}" )
		fi
		if (( verbose )); then
			${einfo} "Services which will be restarted if crashed:"
			${einfo} "$( sed 's/ /, /g' <<<"${rc_monitor_restart[*]:-}" )"
		fi
	fi
fi

(( verbose )) && ${ebegin} "Checking for crashed services"

declare -i rc=0
declare -i monitored=0

for svc in $( rc-status --crashed --all ); do
	monitored=0

	for chk in "${rc_monitor_restart[@]:-}"; do
		if [[ -n "${chk:-}" && "${chk}" == "${svc:-}" ]]; then
			monitored=1

			# We use --nodeps as a restart could stop critical services that
			# depend on us...
			declare -i result=0
			if rc-service "${svc}" -- ${quiet:-} --nodeps restart; then
				(( 0 == rc )) && rc=1
			else
				${eerror} "Service ${svc} failed to restart: ${?}"

				${ewarn} "Attempting to stop then start service ${svc} ..."
				rc-service "${svc}" -- ${quiet:-} --nodeps stop
				rc-service "${svc}" -- ${quiet:-} --nodeps start
				result=${?}
				if ! (( result )); then
					(( 0 == rc )) && rc=1
				else
					rc=2
					${eerror} "Service ${svc} failed to stop/start: ${result}"
				fi
			fi
			continue 2
		fi
	done
	if (( monitored )); then
		${ewarn} "Service '${svc:-}' crashed but requires a manual restart"
		rc=2
	else
		${ewarn} "Service '${svc:-}' crashed but is not monitored and so will not be restarted"
	fi
done
(( verbose )) && ${eend} $(( 2 == rc )) "Crashed services are present which could not be restarted"

(( trace )) && set +o xtrace

exit $(( 0 != rc ))
