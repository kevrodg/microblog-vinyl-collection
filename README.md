# Vinyl Collection

A Micro.blog plug-in for tracking your vinyl record collection. Add records as easily as writing a regular post!

## Installation

1. Go to **Plug-ins** in your Micro.blog account
2. Click **Find Plug-ins** and search for "Vinyl Collection", or click **New Plug-in** and enter `https://github.com/kevrodg/microblog-vinyl-collection` as the Clone URL
3. Click **Install** or **Add Plug-in**

## Quick Start

### 1. Create a "Vinyl" Category

Go to **Posts → Categories** and create a new category called "Vinyl" (case-sensitive).

### 2. Add a Record

Create a new post with this format:

```
🎵 Kind of Blue
Artist: Miles Davis
Year: 1959
Label: Columbia
Format: LP
Genres: Jazz, Modal Jazz

Just picked this up at the local record store. Original pressing in great condition!
```

### 3. Assign the Category

Select the "Vinyl" category for your post, add a cover photo if you have one, and publish!

Your record will now appear in your collection at `yoursite.micro.blog/categories/vinyl/`.

## Post Format

The first line is the album title (you can start with an emoji like 🎵 or 💿).

Then include any of these fields (all optional):
- `Artist:` - Artist or band name
- `Year:` - Release year
- `Label:` - Record label
- `Format:` - LP, 7", 12", etc.
- `Genres:` - Comma-separated list

Anything after the fields becomes your personal notes about the record.

### Minimal Example

```
Rumours
Artist: Fleetwood Mac
```

### Full Example

```
🎵 Abbey Road
Artist: The Beatles
Year: 1969
Label: Apple Records
Format: LP
Genres: Rock, Pop

One of my all-time favorites. Found this at a garage sale for $5!
The vinyl is in surprisingly good condition.
```

## Adding Cover Photos

When creating your post, upload a photo before or after your text. Micro.blog will include it in your post's front matter, and the plugin will display it as the album cover.

## Viewing Your Collection

- **Collection Page**: Visit `/categories/vinyl/` to see all your records
- **Individual Records**: Click any record to see full details

## Embedding in Posts

You can embed your vinyl collection in any blog post:

```markdown
{{</* vinyl */>}}
```

Show only the first 6 records:

```markdown
{{</* vinyl limit="6" */>}}
```

## Configuration

In **Plug-ins → Vinyl Collection → Settings**, you can customize:

- **Page Title**: The heading displayed on your collection page (default: "Vinyl Collection")
- **Category Name**: The category to use for vinyl posts (default: "Vinyl")

## Tips

- **Photos**: The first photo becomes the cover. Additional photos appear as a gallery on the record's detail page.
- **Genres**: Separate multiple genres with commas: `Genres: Rock, Blues, Soul`
- **Notes**: Everything after the metadata fields becomes your personal notes, which supports Markdown formatting.

## License

MIT
