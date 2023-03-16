# Ghost to Jekyll converter

Convert ghost posts to markdown files ready to use with Jekyll.

Turns this

```html
<h1>Blog Title</h1><p>Blog content.</p>
```

Into a file called `2023-01-15-blog-title.md` containing this

```markdown
---
title: Blog Title
---

# Blog Title

Blog content.
```

## Installation

### Docker

From the root directory of the repo, build the docker image.

```bash
docker build -t ghost-to-jekyll .
```

### Manual

[Install `ruby v3.1.3`](https://www.ruby-lang.org/en/documentation/installation/) manually or using a ruby version manager like [rbenv](https://github.com/rbenv/rbenv).

Install dependencies.

```bash
bundle install
```

## Usage

Export your Ghost content using a web browser or the CLI. More info available [here](https://ghost.org/help/the-importer/#exports-in-ghost).

Then run `ruby bin/ghost_to_jekyll -f <path-to-backup-file>.json` or for Docker

```sh
docker run -v <volume-name>:/root/ghost-to-jekyll/converted_posts ghost-to-jekyll -f <path-to-backup-file>.json
```

### Converted files location

When running locally without Docker, files are saved to your home directory `$HOME/ghost-to-jekyll/converted_posts`.

When running with Docker the converted files will be saved to the volume which you specify. To learn more about how volumes work in Docker [go here](https://docs.docker.com/storage/volumes/).

