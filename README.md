# lurk.jp

My personal site. Built with [Hugo](https://gohugo.io). Minimal, content-first, zero JavaScript.

## Structure

```
content/
  _index.md          home
  about.md           about page
  gallery.md         gallery
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
    style.css        main stylesheet (~200 lines)
    404-style.css    3D 404 page styles
  images/            gallery images (WebP)
  favicon.svg        SVG favicon
  _headers           security + cache headers
  robots.txt
```

## Build

```
hugo --minify && bash generate_redirects.sh
```

Output goes to `public/`. Redirects are generated from the `REDIRECTS_JSON` environment variable.

## Stack

- Hugo (static site generator)
- Zero JavaScript
- ~200 lines of CSS
- System fonts (Iowan Old Style / Palatino)
- WebP images
- RSS feed at `/blog/index.xml`
- Security headers (CSP, HSTS, CORP, COOP)

## License

[GPL-3.0](LICENSE)
