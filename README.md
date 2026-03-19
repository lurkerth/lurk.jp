# personal site

A minimal personal website built with [Hugo](https://gohugo.io). Zero JavaScript, content-first, static.

## structure

```
content/
  _index.md          home
  about.md           about page
  gallery.md         gallery
  rss.md             rss feed page
  blog/
    _index.md        blog listing
    *.md             posts
layouts/
  index.html         home template
  _default/
    single.html      page template (about, gallery)
    list.html        generic list (tags)
  blog/
    list.html        blog listing (grouped by year)
    single.html      blog post
  404.html           custom 404 page
  shortcodes/
    gallery.html     image gallery
    blanklink.html   external link
static/
  css/
    style.css        main stylesheet
  images/            gallery images (webp)
  favicon.svg        svg favicon
  _headers           security + cache headers
  robots.txt
```

## build

```
hugo --minify && bash generate_redirects.sh
```

Output goes to `public/`. Redirects are generated from a `REDIRECTS_JSON` environment variable.

## stack

- Hugo (static site generator)
- Zero JavaScript
- System fonts (Iowan Old Style / Palatino)
- WebP images
- RSS feed at `/blog/index.xml`
- Security headers (CSP, HSTS, CORP, COOP)

## license

[GPL-3.0](LICENSE)
