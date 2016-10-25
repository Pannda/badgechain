## How to Publish a Blog Post

**Make sure that you are viewing the `gh-pages` branch of this repo!**

### Blog Post format

Blog post should be written in Markdown with the appropriate YAML Front Matter filled out.

**Schema**

```
---
layout: post
title: { The title of your post }
author: { The author of the post }
author-image: { location of the image for post thumbnail }
---

{ Post Content }

```

**Example**

```
---
layout: post
title: Coming Soon!
author: UT Badgechain Team
author-image: /images/utbadgechain-logo.png
---

We are working on our first post. It should be up soon!

```


### Markdown file naming schema

Markdown file names should follow the following schema:

`YYYY-MM-DD-{title-slug}.md`

The date in the file name will be used as the posted date.

### Create a Draft

Markdown files that are placed within the `_draft/` directory will not be published.

### Publishing a Post

To publish a post, either move a draft to the `_posts/` directory or create a new Markdown file within the `_posts/` directory.

**Remember to commit changes**
