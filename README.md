MignoloLab.org
==============

Sito web di MignoloLab: [www.mignololab.org](https://www.mignololab.org)

Costruito con [Jekyll](https://jekyllrb.com/). Dopo ogni push GitHub produrrà il sito e lo caricherà nel branch `gh-pages`.

## Aggiungere un progetto

* Creare una cartella per il progetto in `_posts`, es. `_posts/adattatore_cell_caval`
* Creare la pagina HTML del progetto in `_posts/adattatore_cell_caval/2015-05-10-adattatore_cell_caval.html`, valorizzando la data come nell'esempio nel nome del file
* Caricare immagini in `_posts/nome_progetto/images`

La pagina HTML del progetto non ha bisogno del `<div>` del titolo (sarà costruito automaticamente, inclusa la targhetta della difficoltà),
ma dovrà avere un blocco in YAML all'inizio strutturato così (sono i metadati del progetto):

```yaml
---
layout: project
title: "Costruire un supporto per cellulari da cavalletto"
summary: "Come adattare un porta cellulare per il supporto al cavalletto."
category: difficulty-low
poster: adattatore_cell_caval/images/adattatore_cell_cavalletto.png
permalink: /projects/:title/
---
```

La categoria del post può essere `difficulty-low`, `difficulty-medium` o `difficulty-high`.  
Gli attributi `layout` e `permalink` devono rimanere così, sono stringhe cablate di configurazione.

A quel punto basterà committare e pushare: GitHub si occuperà di costruire e pubblicare il sito (entro 3-4 minuti).
