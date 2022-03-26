#!/bin/sh

case "$(file --dereference --brief --mime-type -- "$1")" in
	text/*) bat --terminal-width "$4" -f "$1" ;;
esac

exit 1
