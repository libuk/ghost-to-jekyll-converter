# Ghost to Jekyll converter

Convert ghost posts to markdown files ready to use with Jekyll.

## Installation

### Docker

From the root directory of the repo, build the docker image.

```bash
docker build -t ghost-to-jekyll .
```

### Manual

[Install `ruby v3.1`](https://www.ruby-lang.org/en/documentation/installation/).

Install dependencies.

```bash
bundle install
```

## Usage

1. Export your Ghost content using a web browser or the CLI. More info available [here](https://ghost.org/help/the-importer/#exports-in-ghost).

2. Paste the JSON data into the file `backup.json`

3. Run `ruby ghost_to_jekyll.rb` or `docker run --name g-to-j -t ghost-to-jekyll`

