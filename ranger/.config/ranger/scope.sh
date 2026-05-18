#!/usr/bin/env bash

# =========================================================
# RANGER PREVIEW SCRIPT
# =========================================================
#
# Minimal preview script for a terminal-first workflow.
#
# Focus:
# - text/code previews with bat/batcat
# - JSON formatting
# - PDF text preview
# - archive listing
# - Kitty image preview
# - simple fallback output
#
# =========================================================

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'


# =========================================================
# SCRIPT ARGUMENTS
# =========================================================

FILE_PATH="${1}"
PV_WIDTH="${2}"
PV_HEIGHT="${3}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5}"

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"


# =========================================================
# COMMAND DETECTION
# =========================================================

# Ubuntu often installs bat as "batcat".
# Other systems may provide it as "bat".
if command -v bat >/dev/null 2>&1; then
    BAT_CMD="bat"
elif command -v batcat >/dev/null 2>&1; then
    BAT_CMD="batcat"
else
    BAT_CMD=""
fi


# =========================================================
# IMAGE PREVIEW
# =========================================================

# Let Ranger/Kitty display images directly.
if [[ "${PV_IMAGE_ENABLED}" == "True" ]]; then
    case "${MIMETYPE}" in
        image/*)
            exit 7
            ;;
    esac
fi


# =========================================================
# EXTENSION-BASED PREVIEWS
# =========================================================

case "${FILE_EXTENSION_LOWER}" in

    # -----------------------------------------------------
    # JSON
    # -----------------------------------------------------
    json)
        if command -v jq >/dev/null 2>&1; then
            jq --color-output . "${FILE_PATH}" && exit 5
        fi

        python3 -m json.tool -- "${FILE_PATH}" && exit 5
        exit 2
        ;;


    # -----------------------------------------------------
    # PDF
    # -----------------------------------------------------
    pdf)
        if command -v pdftotext >/dev/null 2>&1; then
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - \
                | fmt -w "${PV_WIDTH}" && exit 5
        fi

        file --dereference --brief -- "${FILE_PATH}" && exit 5
        exit 1
        ;;


    # -----------------------------------------------------
    # ZIP ARCHIVES
    # -----------------------------------------------------
    zip)
        if command -v unzip >/dev/null 2>&1; then
            unzip -l "${FILE_PATH}" && exit 5
        fi

        file --dereference --brief -- "${FILE_PATH}" && exit 5
        exit 1
        ;;


    # -----------------------------------------------------
    # TAR ARCHIVES
    # -----------------------------------------------------
    tar|gz|bz2|xz|tgz)
        if command -v tar >/dev/null 2>&1; then
            tar -tf "${FILE_PATH}" && exit 5
        fi

        file --dereference --brief -- "${FILE_PATH}" && exit 5
        exit 1
        ;;

esac


# =========================================================
# MIME-BASED PREVIEWS
# =========================================================

case "${MIMETYPE}" in

    # -----------------------------------------------------
    # TEXT / CODE
    # -----------------------------------------------------
    text/*|*/xml)
        if [[ -n "${BAT_CMD}" ]]; then
            "${BAT_CMD}" \
                --color=always \
                --style=plain \
                --line-range=:300 \
                -- "${FILE_PATH}" && exit 5
        fi

        exit 2
        ;;


    # -----------------------------------------------------
    # AUDIO / VIDEO METADATA
    # -----------------------------------------------------
    video/*|audio/*)
        if command -v mediainfo >/dev/null 2>&1; then
            mediainfo "${FILE_PATH}" && exit 5
        fi

        file --dereference --brief -- "${FILE_PATH}" && exit 5
        exit 1
        ;;

esac


# =========================================================
# FALLBACK
# =========================================================

echo "----- File Type -----"
file --dereference --brief -- "${FILE_PATH}" && exit 5

exit 1
