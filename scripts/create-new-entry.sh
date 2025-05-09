#!/bin/bash

# Script to create a new entry in the data engineering knowledge base

# Function to display usage instructions
usage() {
  echo "Usage: $0 <entry-type> <title> [destination-directory]"
  echo ""
  echo "Entry types:"
  echo "  topic          - Create a new topic page"
  echo "  book           - Create a new book notes page"
  echo "  article        - Create a new article summary"
  echo "  case-study     - Create a new case study"
  echo "  personal       - Create a new personal article"
  echo ""
  echo "Examples:"
  echo "  $0 topic 'Data Mesh Architecture' docs/architectures"
  echo "  $0 book 'Fundamentals of Data Engineering' resources/books"
  exit 1
}

# Check if required parameters are provided
if [ $# -lt 2 ]; then
  usage
fi

ENTRY_TYPE=$1
TITLE=$2
DATE=$(date +%Y-%m-%d)

# Define template paths
TEMPLATE_DIR="templates"
TOPIC_TEMPLATE="${TEMPLATE_DIR}/topic-template.md"
BOOK_TEMPLATE="${TEMPLATE_DIR}/book-template.md"
ARTICLE_TEMPLATE="${TEMPLATE_DIR}/article-template.md"
CASE_STUDY_TEMPLATE="${TEMPLATE_DIR}/case-study-template.md"
PERSONAL_TEMPLATE="${TEMPLATE_DIR}/personal-article-template.md"

# Function to create filename from title
create_filename() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//'
}

# Set the template based on entry type
case $ENTRY_TYPE in
  "topic")
    TEMPLATE=$TOPIC_TEMPLATE
    DEFAULT_DIR="docs"
    FILENAME=$(create_filename "$TITLE").md
    ;;
  "book")
    TEMPLATE=$BOOK_TEMPLATE
    DEFAULT_DIR="resources/books"
    FILENAME=$(create_filename "$TITLE").md
    ;;
  "article")
    TEMPLATE=$ARTICLE_TEMPLATE
    DEFAULT_DIR="resources/articles"
    FILENAME="${DATE}-$(create_filename "$TITLE").md"
    ;;
  "case-study")
    TEMPLATE=$CASE_STUDY_TEMPLATE
    DEFAULT_DIR="docs/case-studies"
    FILENAME=$(create_filename "$TITLE").md
    ;;
  "personal")
    TEMPLATE=$PERSONAL_TEMPLATE
    DEFAULT_DIR="personal"
    FILENAME="${DATE}-$(create_filename "$TITLE").md"
    ;;
  *)
    echo "Error: Invalid entry type '$ENTRY_TYPE'"
    usage
    ;;
esac

# Set the destination directory
if [ $# -ge 3 ]; then
  DEST_DIR=$3
else
  DEST_DIR=$DEFAULT_DIR
fi

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Create the new file
OUTPUT_FILE="$DEST_DIR/$FILENAME"

# Copy the template and replace the title
sed "s/\[Topic Title\]/$TITLE/g; s/\[Book Title\]/$TITLE/g; s/\[Article Title\]/$TITLE/g; s/\[Case Study Title\]/$TITLE/g; s/YYYY-MM-DD/$DATE/g" "$TEMPLATE" > "$OUTPUT_FILE"

echo "Created new $ENTRY_TYPE entry: $OUTPUT_FILE"
echo "Edit this file to add your content." 