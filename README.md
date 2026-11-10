# pbnj.github.io

Personal site: profile, blog, and resume. Plain HTML and CSS, served by GitHub
Pages from `main` with no build step (`.nojekyll` turns Jekyll off). Posts are written in Markdown and
rendered to HTML with pandoc before committing.

## Layout

| Path                  | What                                          |
| --------------------- | --------------------------------------------- |
| `index.html`          | Profile, recent posts, projects               |
| `blog/index.html`     | Post list                                     |
| `posts/*.md`          | Post sources: Markdown with YAML front matter |
| `blog/<slug>.html`    | Generated posts; don't edit by hand           |
| `scripts/build-posts` | Builds posts, post lists, and `feed.xml` (needs pandoc) |
| `resume.html`         | Resume; print it or save it as PDF from the browser |
| `feed.xml`            | RSS feed                                      |
| `assets/style.css`    | All styles, light and dark                    |

## Add a post

1. Create `posts/<slug>.md`:

   ```markdown
   ---
   title: "Post title"
   date: 2026-01-31
   description: "Optional one-line summary"
   ---

   Body in GitHub-flavored Markdown.
   ```

2. Run `scripts/build-posts`. It renders every post to `blog/<slug>.html`,
   refreshes the lists in `blog/index.html` and `index.html`, and rewrites
   `feed.xml`. Posts with `draft: true` are skipped.
3. Commit the Markdown and the generated files.

## Tasks

Run with [mise](https://mise.jdx.dev) (`mise tasks` lists them):

| Task            | What                                                        |
| --------------- | ----------------------------------------------------------- |
| `preview:start` | Serve the site at <http://localhost:8000> in the background |
| `preview:stop`  | Stop the preview server                                     |
| `posts:build`   | Run `scripts/build-posts`                                   |
| `prek:install`  | Install the git hooks (banned-words checks)                 |
| `prek:run`      | Run the hooks on every file                                 |

Set `PREVIEW_PORT` to serve on another port.
