#!/bin/bash

# ini - Update ini value in the input stream.
#
# Usage:
#
#     ini FILE key1=value1 key2=value2
#
# Processing:
#   - Leave any line not containing = unprocessed
#   - Commented keys: Removes any prefix # from key in stream
#   - Space handling: Removes any suffix ' ' from key in stream
#   - Simple processing: Splits key and value on first =, escape characters are not recognized

ini() {

	# Process command line parameters

	INI=$1
	shift

	declare -A update
	for kv in "${@}"; do
		IFS='=' read key value <<<"$kv";
		update[$key]=$value
	done

	# Create backup; setup I/O

	if [ ! "$INI" == "-" ]; then
		cp "$INI" "$INI~"
		exec <"$INI~"
		exec >"$INI"
	fi

	# Process lines

	while read line; do
		if IFS='=' read key value <<<"$line" && [ -n "$value" ]; then
			key=${key% }
			line="${key}=${update[${key#\#}]-$value}"
		fi
		echo "$line"
	done

	# Diff

	if [ ! "$INI" == "-" ]; then
		diff -s "$INI~" "$INI" >&2
	fi
}

ini-test() {
	read -d '' TEST_INP <<-EOF
	[leavemealone]
	a=1
	b =1
	c= 1
    d = 1
	#e=1
	EOF

	read -d '' TEST_OUT_EXP <<-EOF
	[leavemealone]
	a=2
	b=2
	c=2
	d= 1
	#e=1
	EOF

	TEST_OUT_ACT="$(ini - a=2 b=2 c=2 <<<"$TEST_INP")"
	test "$TEST_OUT_ACT" == "$TEST_OUT_EXP" && echo "Self-test PASSED." || echo "Self-test failed."
}

# No harm in being a little pythonic
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    ini-test
fi
