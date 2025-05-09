# Scripts

This directory contains utility scripts to help manage and navigate the data engineering knowledge base.

## Available Scripts

- `create-new-entry.sh`: Creates new content entries based on templates
- `search.sh`: Searches through content by keywords or tags

## Usage

### Creating New Content

```bash
./create-new-entry.sh <entry-type> <title> [destination-directory]
```

Entry types:
- `topic`: Create a new topic page
- `book`: Create a new book notes page
- `article`: Create a new article summary
- `case-study`: Create a new case study
- `personal`: Create a new personal article

Examples:
```bash
./create-new-entry.sh topic "Data Mesh Architecture" docs/architectures
./create-new-entry.sh book "Fundamentals of Data Engineering" resources/books
```

### Searching Content

```bash
./search.sh [options] <search-term>
```

Options:
- `-t, --tags`: Search in tags only (e.g., #data-engineering)
- `-f, --files`: Show only file names, not content matches
- `-d, --dir DIR`: Limit search to a specific directory
- `-h, --help`: Display help message

Examples:
```bash
./search.sh "data lake"                # Search for 'data lake' in all content
./search.sh -t "architecture"          # Search for '#architecture' tag
./search.sh -d docs/fundamentals etl   # Search for 'etl' in fundamentals directory
```

## Adding New Scripts

When adding new utility scripts:

1. Make the script executable with `chmod +x scripts/script-name.sh`
2. Add documentation to this README file
3. Use consistent command-line argument patterns
4. Include appropriate help/usage messages 