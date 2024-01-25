#!/bin/bash
# Set pomodoro_time=X when X is in $0 like pomodoro-set-X.sh

Self="$(basename $0)"

defaults="
# Icon size in pixels
size=24
# Time for the pomodoro cycle (in minutes)
pomodoro_time=45
# Time for the short break cycle (in minutes)
short_break_time=5
# Time for the long break cycle (in minutes)
long_break_time=15
# How many cycles should we do before long break
cycles_between_long_breaks=2
# Time for notification to hang (in seconds)
notify_time=5

"
config_file="${HOME}/.config/pomodoro/config.sh"
if [ ! -f "${config_file}" ]; then
    echo "${defaults}" > "${config_file}"
fi

time=${Self/pomodoro-set-/}
time=${time/.sh/}
let i=${time}+0
if [ ${i} != ${time} ]; then
    echo "time:${time} int error ?! " >&2
    exit 2
fi

# echo "time=${time}"
sed -i -e "/pomodoro_time=/ s@.*@pomodoro_time=${time}@" "${config_file}"
