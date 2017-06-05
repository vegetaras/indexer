# Indexer

Indexer is a RESTful API which allows to index a page's content.

## API

Indexer consists of two endpoints:

* GET `/indexed_items`. Returns indexed items.

* POST `/indexed_items.`. Params: `url` - url of a page to index. Indexes a page and creates indexed item.
