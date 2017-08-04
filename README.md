# CheckAppVersions

Compare git revisions of running apps to latest master in git repo.

A WORK IN PROGRESS !

## Assumptions:

Repo is on github, token for API is known.

Apps respond to an endpoint /internal/version which returns json
including latest git revision.

## Running the script

    $ ./check_app_versions --github http://github.com/someuser/somerepo  \
    >                      --live http://localhost:3000 \
    >                      --live http://localhost:3001

## Development

### Compile standalone script

    mix escript.build

### Test (when tests are written)

    mix test

### REPL

    iex -S mix
