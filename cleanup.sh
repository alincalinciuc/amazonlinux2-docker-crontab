#!/bin/bash -e
NUMBER="$(find /tmp/ServiceName*/*.* -mmin +120 -exec du -sh {} \; | wc -l)"
echo "'$NUMBER' files will be deleted." > "/proc/$(pgrep java)/fd/1"
find /tmp/ServiceName*/*.* -mmin +120 -exec du -sh {} \; &> "/proc/$(pgrep java)/fd/1"
find /tmp/ServiceName*/*.* -mmin +120 -exec rm {} \;
