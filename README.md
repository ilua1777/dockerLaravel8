<p align="center">
  <img src="https://miro.medium.com/max/1200/1*A4jx36gnjKSZNSlNP6AJlg.png" alt="" style="width: 100%" />
</p>

## System requirements

For local application starting (for development) make sure that you have locally installed next applications:

- `docker >= 18.0` _(install: `curl -fsSL get.docker.com | sudo sh`)_
- `docker-compose >= 1.22` _([installing manual][install_compose])_
- `make >= 4.1` _(install: `apt-get install make`)_

## Used services

This application uses next services:

- PHP-FPM8.1
- PostgreSQL13.7
- PgAdmin
- NGINX
- NODE16.6

Declaration of all services can be found into `./docker-compose.yml` file.

## Work with application

Most used commands declared in `./Makefile` file. For more information execute in your terminal `make help`.

Here are just a few of them:

Command signature | Description
----------------- | -----------
`make build` | Build all Docker images from using own Docker files
`make up`    | Run all application containers into background mode
`make down`  | Stop all started application containers
`make restart` | Restart all application containers
`make shell` | Start shell into application container
`make install` | Make install all `composer` and `node` dependencies
`make watch` | Run `npm run dev` _(for frontend-development)_
`make init` | Make **full** application initialization

After application starting you can open [127.0.0.1:8080](http://127.0.0.1:8080/) in your browser.
After application starting you can open [127.0.0.1:5050](http://127.0.0.1:5050/) in your browser from PhpPgAdmin.

### Fast application starting

Just execute into your terminal next commands:

```bash
$ git clone https://github.com/ilua1777/dockerLaravel8.git ./laravel-project && cd $_
```