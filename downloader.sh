#!/bin/bash
# shellcheck disable=SC2115


##############################################################
#
# Download JFK Assassination Records - 2025 Documents Release
#
##############################################################

# After progress for download files finish, you can add documents to a local private running AI gpt client.
# Make it read them and start questions...

CWD=$(pwd)
SITE="https://www.archives.gov"
DIR="PDFs"
URLs="$CWD/url_pdf.txt"
LOG_FILE="$CWD/download_log.txt"

if [ ! -f "$URLs" ]; then
  echo "URLs file $URLs not found!" >&2
  exit 1
fi

if [ -d "$CWD/$DIR" ]; then
  rm -rf "$CWD/$DIR"
fi

mkdir -p "$CWD/$DIR" || { echo "Failed to create directory $CWD/$DIR" >&2; exit 1; }

pushd "$CWD/$DIR" || { echo "Failed to change directory to $CWD/$DIR" >&2; exit 1; }

echo "Download Log - $(date)" > "$LOG_FILE"
echo "====================================" >> "$LOG_FILE"

echo "Starting download process..."

while IFS= read -r url; do
  if [[ -n "$url" ]]; then
    url=$(echo "$url" | xargs)

    full_url="$SITE$url"

    if curl -C - -O "$full_url" > /dev/null 2>&1; then
      echo "$(date): Downloaded $full_url" >> "$LOG_FILE"
    else
      echo "Error downloading: $full_url" >&2
    fi
  fi
done < "$URLs"


if [ ! -f "104-10004-10143 (C06932208).pdf" ]; then
  wget -c "https://www.archives.gov/files/research/jfk/releases/2025/0318/104-10004-10143 (C06932208).pdf"
fi
if [ ! -f "104-10105-10290 (C06932214).pdf" ]; then
  wget -c "https://www.archives.gov/files/research/jfk/releases/2025/0318/104-10105-10290 (C06932214).pdf"
fi
if [ ! -f "104-10326-10014 (c06931192).pdf" ]; then
 wget -c "https://www.archives.gov/files/research/jfk/releases/2025/0318/104-10326-10014 (c06931192).pdf"
fi
if [ ! -f "124-10185-10099 (c06716626).pdf" ]; then
 wget -c "https://www.archives.gov/files/research/jfk/releases/2025/0318/124-10185-10099 (c06716626).pdf"
fi
if [ ! -f "124-10274-10011 (c06716583).pdf" ]; then
 wget -c "https://www.archives.gov/files/research/jfk/releases/2025/0318/124-10274-10011 (c06716583).pdf"
fi
if [ ! -f "124-10276-10400 (c06716411).pdf" ]; then
 wget -c "https://www.archives.gov/files/research/jfk/releases/2025/0318/124-10276-10400 (c06716411).pdf"
fi

popd || { echo "Failed to change directory to $CWD" >&2; exit 1; }
echo "Download process completed. Check the log file for details: $LOG_FILE"
