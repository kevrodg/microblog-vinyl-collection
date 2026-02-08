# Vinyl Collection

A Micro.blog plug-in for tracking your vinyl record collection.

## Installation

### From GitHub (Development/Testing)

1. Go to **Design** in your Micro.blog account
2. Click **Edit Custom Themes**
3. Click **New Theme**
4. Enter `https://github.com/kevrodg/microblog-vinyl-collection` as the Clone URL
5. Click **Add Theme**
6. Go to **Plug-ins** and install the theme as a plug-in

### From Plug-in Directory (Once Published)

1. Go to **Plug-ins** in your Micro.blog account
2. Click **Find Plug-ins** and search for "Vinyl Collection"
3. Click **Install**

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
year: "1959"
format: "LP"
cover: "/uploads/kind-of-blue.jpg"
genres: ["Jazz", "Modal Jazz"]
notes: "Original pressing, excellent condition"
---

Optional additional notes or content here.
```

### Viewing Your Collection

Visit `yoursite.micro.blog/vinyl/` to see your full collection.

### Configuration

In **Plug-ins → Vinyl Collection → Settings**, you can customize:

- **Page Title**: The heading displayed on your collection page

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
