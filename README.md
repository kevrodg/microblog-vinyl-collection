# Vinyl Collection

A Micro.blog plug-in for tracking your vinyl record collection.

## Installation

### From GitHub

1. Go to **Plug-ins** in your Micro.blog account
2. Click **Find Plug-ins**
3. Scroll to the bottom and click **New Plug-in**
4. Enter `https://github.com/kevrodg/microblog-vinyl-collection` as the Clone URL
5. Click **Add Plug-in**
6. The plugin will be installed and you'll see an **Update** button appear whenever a new version is available on GitHub

### From Plug-in Directory (Once Published)

1. Go to **Plug-ins** in your Micro.blog account
2. Click **Find Plug-ins** and search for "Vinyl Collection"
3. Click **Install**
4. Updates will be automatic from the plugin directory

## Usage

### Adding Records

Create markdown files in a `content/vinyl/` directory with front matter like:

```yaml
---
title: "Kind of Blue"
date: 2024-01-15
type: vinyl
artist: "Miles Davis"
album: "Kind of Blue"
label: "Columbia"
year: "1959"
format: "LP"
cover: "/uploads/kind-of-blue.jpg"
genres: ["Jazz", "Modal Jazz"]
description: |
  A landmark album in the history of jazz, featuring John Coltrane
  and Cannonball Adderley. Recorded in a single session in 1959.
pictures:
  - "/uploads/kind-of-blue/back-cover.jpg"
  - "/uploads/kind-of-blue/liner-notes.jpg"
notes: "Original pressing, excellent condition"
---

Optional additional notes or content here.
```

### Viewing Your Collection

Visit `yoursite.micro.blog/vinyl/` to see your full collection.

### Browsing by Taxonomy

The plugin automatically creates pages for browsing your collection by:

- **Artist**: `/artist/the-beatles/`
- **Genre**: `/genres/jazz/`
- **Label**: `/label/blue-note/`
- **Year**: `/year/1969/`
- **Format**: `/format/lp/`

These pages are automatically generated from the front matter in your vinyl records.

### Embedding Records in Blog Posts

You can embed individual vinyl records or your full collection in any blog post using the shortcode:

```markdown
{{</* vinyl id="kind-of-blue" */>}}
```

Or display your entire collection:

```markdown
{{</* vinyl */>}}
```

The `id` should match the filename of your vinyl record (without the `.md` extension).

### Configuration

In **Plug-ins → Vinyl Collection → Settings**, you can customize:

- **Page Title**: The heading displayed on your collection page

### Front Matter Fields

#### Required Fields

- **title**: The record title (defaults to album name)
- **date**: Date added to collection
- **type**: Must be `vinyl`
- **artist**: Artist or band name
- **album**: Album title

#### Optional Fields

- **label**: Record label (e.g., "Columbia", "Blue Note")
- **year**: Release year of this pressing
- **format**: Format type (e.g., "LP", "12\"", "7\"", "45rpm")
- **cover**: Path to cover image
- **genres**: Array of genre tags
- **description**: Detailed album description (supports Markdown)
- **pictures**: Array of additional image paths (back cover, liner notes, etc.)
- **notes**: Personal notes about the record

## File Structure

```
├── plugin.json          # Plugin metadata and settings
├── archetypes/
│   └── vinyl.md         # Template for new vinyl entries
├── layouts/
│   └── vinyl/
│       ├── list.html    # Collection grid view
│       └── single.html  # Individual record page
└── static/
    ├── css/
    │   └── vinyl.css    # Styles
    └── js/
        └── vinyl.js     # JavaScript (future enhancements)
```

## License

MIT
