# pbnj.github.io

Personal site: profile, blog, and resume. Plain HTML and CSS, served by GitHub
Pages from `main` with no build step (`.nojekyll` turns Jekyll off).

## Layout

| Path                  | What                                          |
| --------------------- | --------------------------------------------- |
| `index.html`          | Profile, recent posts, projects               |
| `blog/index.html`     | Post list                                     |
| `blog/_template.html` | Copy this to start a post                     |
| `resume.html`         | Resume; print it or save it as PDF from the browser |
| `feed.xml`            | RSS feed                                      |
| `assets/style.css`    | All styles, light and dark                    |

## Add a post

1. `cp blog/_template.html blog/<slug>.html` and fill it in.
2. Add it to the top of the lists in `blog/index.html` and `index.html`.
3. Add an `<item>` to `feed.xml`.

## Preview locally

```sh
python3 -m http.server 8000
```

Then open <http://localhost:8000>.
