# Laravel Kit

## Usage

1. [install octane + frankenphp](https://laravel.com/docs/11.x/octane)
1. copy files to project
1. run `docker compose up --wait --build --remove-orphans`
1. enjoy your app at `http://localhost`

## Configuration

1. `.env`
```Dotfile
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=sail
DB_PASSWORD=password
```

## Production

Remember to change the default variables to apropriate values.

Avaliable variables:

```Dotfile
APP_FLAVOR=production
APP_HTTP_PORT=80
DB_USERNAME=app
DB_PASSWORD=
DB_ROOT_PASSWORD= # PLEASE, DO NOT USE THE SAME AS DB_PASSWORD
DB_DATABASE=app
```

You should not leave the database port publicly avalible, but if you do, at least disable the root account :)

