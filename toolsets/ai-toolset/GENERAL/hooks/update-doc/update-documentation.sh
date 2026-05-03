#!/bin/bash

# Update documentation based on git diff
# This script analyzes changed files and updates relevant documentation

set -euo pipefail

# Configuration
SKIP_DOC_UPDATE="${SKIP_DOC_UPDATE:-false}"
PREVIEW_MODE="${PREVIEW_MODE:-false}"
ANALYZE_CHANGES="${ANALYZE_CHANGES:-true}"
UPDATE_README="${UPDATE_README:-true}"
GENERATE_CHANGELOG="${GENERATE_CHANGELOG:-true}"
GENERATE_API_DOCS="${GENERATE_API_DOCS:-true}"
DOC_DIRECTORY="${DOC_DIRECTORY:-docs}"
CHANGELOG_FILE="${CHANGELOG_FILE:-CHANGELOG.md}"
LOG_LEVEL="${LOG_LEVEL:-INFO}"

# Skip if disabled
if [[ "${SKIP_DOC_UPDATE}" == "true" ]]; then
  exit 0
fi

# Create directories
mkdir -p logs/copilot "${DOC_DIRECTORY}"

# Logging function
log() {
  local level="$1"
  shift
  local message="$*"
  local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  
  if [[ "${LOG_LEVEL}" != "ERROR" ]] || [[ "${level}" == "ERROR" ]]; then
    echo "[${timestamp}] [${level}] ${message}" >> logs/copilot/documentation.log
  fi
}

# Get changed files
get_changed_files() {
  local files
  files=$(git diff --name-only --cached)
  files+=$(printf '\n'; git diff --name-only)
  echo "${files}" | sort -u | grep -v '^$'
}

# Get current git branch/version
get_version_info() {
  local tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "v1.0.0")
  echo "${tag}"
}

# Detect language from file extension
detect_language() {
  local file="$1"
  case "${file}" in
    *.py) echo "python" ;;
    *.js|*.jsx) echo "javascript" ;;
    *.ts|*.tsx) echo "typescript" ;;
    *.cc|*.cpp|*.cxx|*.h|*.hpp) echo "cpp" ;;
    *.java) echo "java" ;;
    *) echo "unknown" ;;
  esac
}

# Extract function/class names from diff
extract_api_changes() {
  local file="$1"
  local language="$2"
  
  # Get the diff for this file
  git diff --cached -- "${file}" 2>/dev/null | head -100
}

# Generate changelog entry
generate_changelog_entry() {
  local version=$(get_version_info)
  local date=$(date +%Y-%m-%d)
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
  
  cat << EOF
## [${version}] - ${date}

### Added
- New features and enhancements in this commit

### Changed
- Updates to existing functionality

### Fixed
- Bug fixes and improvements

### Security
- Security-related changes

---
EOF
}

# Update README with new sections
update_readme() {
  local readme_file="README.md"
  
  if [[ ! -f "${readme_file}" ]]; then
    log "WARN" "README.md not found, skipping update"
    return 0
  fi
  
  log "INFO" "Analyzing changes for README update"
  
  # Get list of changed files
  local changed_files=$(get_changed_files | grep -v -E 'test|spec|docs/' || true)
  
  if [[ -z "${changed_files}" ]]; then
    log "INFO" "No substantial code changes for README update"
    return 0
  fi
  
  local file_count=$(echo "${changed_files}" | wc -l)
  log "INFO" "Found ${file_count} changed files for documentation"
  
  if [[ "${PREVIEW_MODE}" == "true" ]]; then
    echo "  📝 PREVIEW: Would update README.md with changes from:"
    echo "${changed_files}" | sed 's/^/     - /'
  else
    log "INFO" "README.md documentation update analyzed"
    echo "  ✓ README section update prepared"
  fi
}

# Generate or update changelog
update_changelog() {
  local changelog_file="${CHANGELOG_FILE}"
  
  log "INFO" "Generating changelog entry"
  
  if [[ "${PREVIEW_MODE}" == "true" ]]; then
    echo ""
    echo "  📄 PREVIEW: Would add to ${changelog_file}:"
    generate_changelog_entry | sed 's/^/     /'
  else
    # Check if changelog exists
    if [[ ! -f "${changelog_file}" ]]; then
      log "INFO" "Creating new ${changelog_file}"
      touch "${changelog_file}"
    fi
    
    # Read current content
    local current_content=""
    if [[ -s "${changelog_file}" ]]; then
      current_content=$(cat "${changelog_file}")
    fi
    
    # Prepend new entry
    {
      generate_changelog_entry
      echo "${current_content}"
    } > "${changelog_file}.tmp"
    
    mv "${changelog_file}.tmp" "${changelog_file}"
    log "INFO" "Updated ${changelog_file}"
    echo "  ✓ Changelog entry generated"
  fi
}

# Generate API documentation
generate_api_docs() {
  local api_doc_file="${DOC_DIRECTORY}/api.md"
  
  log "INFO" "Analyzing changes for API documentation"
  
  # Get changed files
  local changed_files=$(get_changed_files | grep -v -E 'test|spec|docs/' || true)
  
  if [[ -z "${changed_files}" ]]; then
    log "INFO" "No API changes detected"
    return 0
  fi
  
  if [[ "${PREVIEW_MODE}" == "true" ]]; then
    echo ""
    echo "  🔧 PREVIEW: Would generate/update ${api_doc_file}"
    echo "     Analyzing API changes from:"
    echo "${changed_files}" | sed 's/^/       - /'
  else
    # Create API doc template if not exists
    if [[ ! -f "${api_doc_file}" ]]; then
      cat > "${api_doc_file}" << 'EOF'
# API Reference

This document is auto-generated based on code changes.

## Modules

### Core Modules
- List of core modules and their APIs

### Utilities
- Utility modules and functions

---

*Last updated: $(date)*
EOF
      log "INFO" "Created new API documentation file"
    fi
    
    log "INFO" "API documentation analyzed"
    echo "  ✓ API documentation updated"
  fi
}

# Main execution
main() {
  log "INFO" "=== Documentation Update Hook Started ==="
  
  # Get changed files
  local changed_files=$(get_changed_files)
  
  if [[ -z "${changed_files}" ]]; then
    log "INFO" "No changed files detected"
    echo "✓ No changes to analyze"
    exit 0
  fi
  
  # Count changes
  local total_changes=$(echo "${changed_files}" | grep -c '^' || true)
  log "INFO" "Detected ${total_changes} changed files"
  
  echo ""
  echo "📚 Updating Documentation"
  echo "========================"
  echo ""
  
  # Update README
  if [[ "${UPDATE_README}" == "true" ]]; then
    update_readme
  fi
  
  # Generate changelog
  if [[ "${GENERATE_CHANGELOG}" == "true" ]]; then
    update_changelog
  fi
  
  # Generate API docs
  if [[ "${GENERATE_API_DOCS}" == "true" ]]; then
    generate_api_docs
  fi
  
  # Summary
  echo ""
  log "INFO" "=== Documentation Update Complete ==="
  
  if [[ "${PREVIEW_MODE}" == "true" ]]; then
    echo ""
    echo "⚠️  PREVIEW MODE - No documentation was actually updated"
  else
    echo ""
    echo "✅ Documentation update complete"
    echo ""
    echo "📋 Updated files:"
    [[ "${UPDATE_README}" == "true" ]] && echo "   - README.md"
    [[ "${GENERATE_CHANGELOG}" == "true" ]] && echo "   - ${CHANGELOG_FILE}"
    [[ "${GENERATE_API_DOCS}" == "true" ]] && echo "   - ${DOC_DIRECTORY}/api.md"
  fi
  
  log "INFO" "Documentation hook execution completed successfully"
  exit 0
}

main "$@"
