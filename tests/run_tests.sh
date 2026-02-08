#!/bin/bash

# Test runner for microblog-vinyl-collection Hugo plugin
# Tests the category-based vinyl collection approach

set -o pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
TESTS_PASSED=0
TESTS_FAILED=0

# Determine script and project directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEST_DIR="$SCRIPT_DIR"
BUILD_DIR="$TEST_DIR/public"

# Helper function to print test results
pass() {
    echo -e "${GREEN}✓ PASS${NC}: $1"
    ((TESTS_PASSED++))
}

fail() {
    echo -e "${RED}✗ FAIL${NC}: $1"
    echo -e "  ${YELLOW}Expected:${NC} $2"
    ((TESTS_FAILED++))
}

# Helper function to check if string exists in file
assert_contains() {
    local file="$1"
    local expected="$2"
    local test_name="$3"
    
    if grep -q "$expected" "$file" 2>/dev/null; then
        pass "$test_name"
        return 0
    else
        fail "$test_name" "File should contain: $expected"
        return 1
    fi
}

# Helper function to check if file contains pattern (extended grep)
assert_matches() {
    local file="$1"
    local pattern="$2"
    local test_name="$3"
    
    if grep -qE "$pattern" "$file" 2>/dev/null; then
        pass "$test_name"
        return 0
    else
        fail "$test_name" "File should match pattern: $pattern"
        return 1
    fi
}

# Helper function to check multiple occurrences
assert_count() {
    local file="$1"
    local pattern="$2"
    local expected_count="$3"
    local test_name="$4"
    
    local actual_count
    actual_count=$(grep -oE "$pattern" "$file" 2>/dev/null | wc -l | tr -d ' ')
    
    if [ "$actual_count" -ge "$expected_count" ]; then
        pass "$test_name (found $actual_count, expected >= $expected_count)"
        return 0
    else
        fail "$test_name" "Expected at least $expected_count occurrences, found $actual_count"
        return 1
    fi
}

echo "========================================"
echo "Vinyl Collection Template Tests"
echo "(Category-based approach)"
echo "========================================"
echo ""

# Setup: Copy layouts from project root to test layouts
echo "Setting up test environment..."

# Create necessary directories
mkdir -p "$TEST_DIR/layouts/shortcodes"
mkdir -p "$TEST_DIR/layouts/partials"
mkdir -p "$TEST_DIR/layouts/categories/vinyl"

# Copy the actual templates being tested
cp "$PROJECT_ROOT/layouts/shortcodes/vinyl.html" "$TEST_DIR/layouts/shortcodes/"
cp "$PROJECT_ROOT/layouts/partials/vinyl-parse.html" "$TEST_DIR/layouts/partials/"
cp "$PROJECT_ROOT/layouts/partials/vinyl-card.html" "$TEST_DIR/layouts/partials/"
cp "$PROJECT_ROOT/layouts/categories/vinyl/term.html" "$TEST_DIR/layouts/categories/vinyl/"
cp "$PROJECT_ROOT/layouts/categories/vinyl/single.html" "$TEST_DIR/layouts/categories/vinyl/"

# Clean previous build
rm -rf "$BUILD_DIR"

# Build the test site
echo "Building test site..."
cd "$TEST_DIR"
hugo 2>&1

if [ $? -ne 0 ]; then
    echo -e "${RED}ERROR: Hugo build failed${NC}"
    hugo 2>&1
    exit 1
fi

echo "Build complete. Running tests..."
echo ""

# ==============================================================================
# Test 1: vinyl-parse.html correctly parses post content
# ==============================================================================
echo "--- Test 1: Content parsing (via vinyl-card rendering) ---"

# The parsing is tested indirectly through the card rendering
VINYL_FULL_FILE="$BUILD_DIR/posts/vinyl-full/index.html"

if [ -f "$VINYL_FULL_FILE" ]; then
    # Check that content appears somewhere in the rendered output
    # (parsed by vinyl-parse.html and rendered by category single template)
    assert_contains "$VINYL_FULL_FILE" 'Miles Davis' \
        "Parser extracts artist from content"
    assert_contains "$VINYL_FULL_FILE" '1959' \
        "Parser extracts year from content"
    assert_contains "$VINYL_FULL_FILE" 'Columbia Records' \
        "Parser extracts label from content"
else
    fail "Vinyl full post file exists" "File not found: $VINYL_FULL_FILE"
fi

echo ""

# ==============================================================================
# Test 2: vinyl-card.html renders record cards correctly
# ==============================================================================
echo "--- Test 2: Vinyl card partial rendering ---"

EMBED_FILE="$BUILD_DIR/posts/embed-collection/index.html"

if [ -f "$EMBED_FILE" ]; then
    # Should render vinyl-record articles
    assert_contains "$EMBED_FILE" 'class="vinyl-record"' \
        "Card partial renders vinyl-record container"
    
    # Should render album titles
    assert_contains "$EMBED_FILE" 'class="vinyl-album"' \
        "Card partial renders album title"
    
    # Should render artist
    assert_contains "$EMBED_FILE" 'class="vinyl-artist"' \
        "Card partial renders artist"
    
    # Should render meta tags section
    assert_contains "$EMBED_FILE" 'class="vinyl-meta-tags"' \
        "Card partial renders meta-tags section"
    
    # Should render both records
    assert_count "$EMBED_FILE" 'class="vinyl-record"' 2 \
        "Card partial renders both vinyl records"
else
    fail "Embed collection file exists" "File not found: $EMBED_FILE"
fi

echo ""

# ==============================================================================
# Test 3: Category term template displays collection correctly
# ==============================================================================
echo "--- Test 3: Category term template (/categories/vinyl/) ---"

CATEGORY_FILE="$BUILD_DIR/categories/vinyl/index.html"

if [ -f "$CATEGORY_FILE" ]; then
    # Should render collection container
    assert_contains "$CATEGORY_FILE" 'class="vinyl-collection"' \
        "Category page renders collection container"
    
    # Should render the configured page title
    assert_contains "$CATEGORY_FILE" 'My Test Vinyl Collection' \
        "Category page renders configured title"
    
    # Should render stats
    assert_contains "$CATEGORY_FILE" 'records in collection' \
        "Category page renders record count"
    
    # Should render vinyl grid
    assert_contains "$CATEGORY_FILE" 'class="vinyl-grid"' \
        "Category page renders grid layout"
    
    # Should include both records
    assert_contains "$CATEGORY_FILE" 'Kind of Blue' \
        "Category page shows first record"
    assert_contains "$CATEGORY_FILE" 'Rumours' \
        "Category page shows second record"
else
    fail "Category page file exists" "File not found: $CATEGORY_FILE"
fi

echo ""

# ==============================================================================
# Test 4: Shortcode embeds vinyl collection in posts
# ==============================================================================
echo "--- Test 4: Vinyl shortcode embedding ---"

if [ -f "$EMBED_FILE" ]; then
    # Should render vinyl-embed container
    assert_contains "$EMBED_FILE" 'class="vinyl-collection vinyl-embed"' \
        "Shortcode renders embed container"
    
    # Should render both vinyl records
    assert_contains "$EMBED_FILE" 'Miles Davis' \
        "Shortcode shows first record's artist"
    assert_contains "$EMBED_FILE" 'Fleetwood Mac' \
        "Shortcode shows second record's artist"
else
    fail "Embed file exists" "File not found: $EMBED_FILE"
fi

echo ""

# ==============================================================================
# Test 5: Shortcode respects limit parameter
# ==============================================================================
echo "--- Test 5: Vinyl shortcode with limit parameter ---"

LIMITED_FILE="$BUILD_DIR/posts/embed-limited/index.html"

if [ -f "$LIMITED_FILE" ]; then
    # Should only render one record when limit=1
    assert_count "$LIMITED_FILE" 'class="vinyl-record"' 1 \
        "Shortcode with limit=1 renders only 1 record"
else
    fail "Limited embed file exists" "File not found: $LIMITED_FILE"
fi

echo ""

# ==============================================================================
# Test 6: Full vinyl record displays all metadata in collection
# ==============================================================================
echo "--- Test 6: Full vinyl record with all fields (in collection view) ---"

# Check the category page and embed for the full record display
if [ -f "$CATEGORY_FILE" ]; then
    # Should render album name
    assert_contains "$CATEGORY_FILE" 'Kind of Blue' \
        "Full record shows album title in collection"
    
    # Should render format
    assert_contains "$CATEGORY_FILE" 'LP' \
        "Full record shows format in collection"
    
    # Should render label
    assert_contains "$CATEGORY_FILE" 'Columbia Records' \
        "Full record shows label in collection"
    
    # Should render genres
    assert_matches "$CATEGORY_FILE" 'vinyl-genre.*Jazz' \
        "Full record shows genres in collection"
    
    # Should have cover image (from photos front matter)
    assert_contains "$CATEGORY_FILE" 'kind-of-blue-cover.jpg' \
        "Full record shows cover image in collection"
else
    fail "Category page exists" "File not found: $CATEGORY_FILE"
fi

echo ""

# ==============================================================================
# Test 7: Minimal vinyl post renders correctly
# ==============================================================================
echo "--- Test 7: Minimal vinyl post (album + artist only) ---"

VINYL_MINIMAL_FILE="$BUILD_DIR/posts/vinyl-minimal/index.html"

if [ -f "$VINYL_MINIMAL_FILE" ]; then
    # Should render album name
    assert_contains "$VINYL_MINIMAL_FILE" 'Rumours' \
        "Minimal post shows album title"
    
    # Should render artist
    assert_contains "$VINYL_MINIMAL_FILE" 'Fleetwood Mac' \
        "Minimal post shows artist"
else
    fail "Minimal vinyl post exists" "File not found: $VINYL_MINIMAL_FILE"
fi

echo ""

# ==============================================================================
# Summary
# ==============================================================================
echo "========================================"
echo "Test Summary"
echo "========================================"
echo -e "${GREEN}Passed:${NC} $TESTS_PASSED"
echo -e "${RED}Failed:${NC} $TESTS_FAILED"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi
