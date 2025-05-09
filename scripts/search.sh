#!/bin/bash

# Script to search through the data engineering knowledge base

# Function to display usage instructions
usage() {
  echo "Usage: $0 [options] <search-term>"
  echo ""
  echo "Options:"
  echo "  -t, --tags       Search in tags only (e.g., #data-engineering)"
  echo "  -f, --files      Show only file names, not content matches"
  echo "  -d, --dir DIR    Limit search to a specific directory"
  echo "  -h, --help       Display this help message"
  echo ""
  echo "Examples:"
  echo "  $0 \"data lake\"                # Search for 'data lake' in all content"
  echo "  $0 -t \"architecture\"          # Search for '#architecture' tag"
  echo "  $0 -d docs/fundamentals etl    # Search for 'etl' in fundamentals directory"
  exit 1
}

# Default values
SEARCH_TAGS=false
FILES_ONLY=false
DIRECTORY="."

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -t|--tags)
      SEARCH_TAGS=true
      shift
      ;;
    -f|--files)
      FILES_ONLY=true
      shift
      ;;
    -d|--dir)
      DIRECTORY="$2"
      shift
      shift
      ;;
    -h|--help)
      usage
      ;;
    *)
      SEARCH_TERM="$1"
      shift
      ;;
  esac
done

# Check if search term is provided
if [ -z "$SEARCH_TERM" ]; then
  echo "Error: No search term provided"
  usage
fi

# Format search term for tags if needed
if [ "$SEARCH_TAGS" = true ]; then
  # Remove # if user already included it
  SEARCH_TERM=$(echo "$SEARCH_TERM" | sed 's/^#//')
  SEARCH_PATTERN="#$SEARCH_TERM"
else
  SEARCH_PATTERN="$SEARCH_TERM"
fi

# Execute the search
if [ "$FILES_ONLY" = true ]; then
  # Show only file names
  if [ "$SEARCH_TAGS" = true ]; then
    grep -l "$SEARCH_PATTERN" $(find "$DIRECTORY" -name "*.md")
  else
    grep -l -i "$SEARCH_PATTERN" $(find "$DIRECTORY" -name "*.md")
  fi
else
  # Show matching content with context
  if [ "$SEARCH_TAGS" = true ]; then
    grep -n --color=always -A 1 -B 1 "$SEARCH_PATTERN" $(find "$DIRECTORY" -name "*.md")
  else
    grep -n --color=always -i -A 1 -B 1 "$SEARCH_PATTERN" $(find "$DIRECTORY" -name "*.md")
  fi
fi 