# personal site

A minimal personal website built with [Hugo](https://gohugo.io). Zero JavaScript, content-first, static.

## structure

```
content/
  _index.md          home
  about.md           about page
  rss.md             rss feed page
  blog/
    _index.md        blog listing
    *.md             posts
layouts/
  index.html         home template
  _default/
    single.html      page template (about)
    list.html        generic list (tags)
    rss.xml          rss feed template
  blog/
    list.html        blog listing (grouped by year)
    single.html      blog post
  partials/
    head.html        shared head
    nav.html         shared navigation
    footer.html      shared footer
  404.html           custom 404 page
  shortcodes/
    blanklink.html   external link
static/
  css/
    style.css        main stylesheet
  favicon.svg        svg favicon
  favicon.ico        ico favicon (for rss readers)
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
- RSS feed at `/blog/index.xml`
- Security headers (CSP, HSTS, CORP, COOP, COEP)

## license

[GPL-3.0](LICENSE)
