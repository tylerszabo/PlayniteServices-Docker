# Dockerized Playnite Services

Runs the backend for [Playnite][1] in a Docker container.

## Running

1. Create `customSettings.json` and define config options that should not be included in the repo, such as API keys. Values will override those set in `appsettings.json`, which can be used as a template.
2. Run with `docker-compose up`.

  [1]: https://github.com/JosefNemec/Playnite
