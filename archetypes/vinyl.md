---
# Required Fields
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
type: vinyl

# Artist and Album Information
# The artist/band name
artist: ""

# The album title (if different from title above)
album: ""

# Record Label
# The label that published the record (e.g., "Columbia", "Blue Note")
label: ""

# Release Year
# The year this pressing was released
year: ""

# Format
# Examples: "LP", "12\"", "7\"", "10\"", "33rpm", "45rpm", "78rpm"
format: "LP"

# Cover Image
# Path to the album cover image (e.g., "/uploads/album-cover.jpg")
cover: ""

# Genres
# List of genres this record belongs to
genres: []

# Description
# A detailed description of the album. Markdown is supported.
# Uncomment the lines below to add a description:
# description: |
#   This is a classic album from 1969...

# Additional Pictures
# List of additional images (back cover, liner notes, vinyl label, etc.)
# These pictures should be in your uploads or static folder
# pictures:
#   - "/uploads/album-name/back-cover.jpg"
#   - "/uploads/album-name/liner-notes.jpg"
#   - "/uploads/album-name/label.jpg"

# Personal Notes
# Your personal notes about this record (condition, where you got it, etc.)
notes: ""
---

<!-- Optional: Add any additional content here. This will appear on the single record page. -->
