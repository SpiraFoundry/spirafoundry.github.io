# Spira Foundry

Static website for **Spira Foundry** — an independent software duo building focused, lightweight tools and utility applications, including **Cain's Codex**.

Built with [Dart](https://dart.dev) and [Jaspr](https://jaspr.site) (`static` mode).

## Pages

- `/` — Home overview, featured projects, and creator profiles
- `/projects` — Published projects showcase with category filters and feature carousel
- `/about` — About Spira Foundry and creators
- `/cains-codex/privacy-policy` — Privacy Policy for Cain's Codex
- `/cains-codex/terms-of-use` — Terms of Use for Cain's Codex

## Project Structure

- `lib/` — Jaspr application, router, pages, UI components, and site content (`lib/data/site_content.dart`)
- `web/` — Stylesheets (`styles.css`), WebGL background shader (`js/shader.js`), favicons, logos, and images
- `test/` — Unit tests for routing data, project metadata, and web assets
- `.github/workflows/deploy.yml` — GitHub Pages build, quality checks, and deployment workflow

## Getting Started

### Prerequisites

- Dart SDK `^3.10.0`
- Jaspr CLI:

```sh
dart pub global activate jaspr_cli 0.23.5
```

### Run Locally

```sh
dart pub get
jaspr serve
```

The development server runs at `http://localhost:8080`.

### Checks & Production Build

```sh
dart format --output=none --set-exit-if-changed lib test
dart analyze --fatal-infos
dart test
jaspr build
```

Static output is generated in `build/jaspr/`.

## Deployment

Pushes to `main` trigger [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml), which runs formatting, static analysis, and tests before building with GitHub Pages `BASE_HREF` and deploying the `build/jaspr` artifact.
