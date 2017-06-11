#!/bin/zsh

ME="${0:t:r}"

CHANNEL="${ME:s/add-/}"

REPO="${PWD:t:r}.git"

while getopts c: c; do
	case "${c}" in
	c )	CHANNEL="${OPTARG}";;
	esac
done
shift $(( ${OPTIND} - 1 ))
if [[ "${1}" != '' ]]; then
	REPO="${1}"
	shift 1
fi
if [[ $# -gt 0 ]]; then
	echo 'ignoring arguments' 2>&1
	exit 1
fi
case "${CHANNEL}" in
github	) URL="git@github.com:megacoder/${REPO}";;
local	) URL="ssh://reynolds@git.darkzone.un:2223/home/vault/depot/${REPO}";;
*	)
	echo "Boss, I don't know about any ${CHANNEL}-related URL." >&2
	exit 1
esac
exec ${DEBUG} /bin/git remote add --mirror=push "${CHANNEL}" "${URL}"
