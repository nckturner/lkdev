#! /bin/bash

function util::trap_add_handler() {
  local trap_sig="${1}"
  shift
  local cmd="$@"
  local current="$(trap -p ${trap_sig} | awk -F\' '{print $2}')"
  if [[ ! -z "${current}" ]]; then
    cmd="${current};${cmd}"
  fi
  trap -- "${cmd}" "${trap_sig}"
}

function util::defer() {
  local cmd="$@"
  util::trap_add_handler "EXIT"    "${cmd}"
  util::trap_add_handler "SIGINT"  "${cmd}"
  util::trap_add_handler "SIGTERM" "${cmd}"
}

function util::print_stack {
  local frame=0
  while caller $frame; do
    ((frame++));
  done
}

function util::start_trace() {
  PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -o xtrace
}

function util::join() {
  local IFS="$1"
  shift
  echo "$*"
}
