## User

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| name | string |
| email | string |

## Task

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| name | string |
| status | string |
| priority | integer |
| deadline | date |
| user_id | integer |

## Label

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| name | string |

## TaskLabel

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| task_id | integer |
| label_id | integer |

## Deployment

This application is deployed to Heroku. Here are the steps to deploy the application:


### Log in to Heroku
```sh
heroku login
```

### Create a new Heroku app (replace <your-app-name> with the name you want)
```sh
heroku create <your-app-name>
```

### Push the application to Heroku
```sh
git push heroku step2:master
```
Gems
Here are the main gems used in this project:

## Gems

Here are the main gems used in this project:

- Ruby: 3.0.1
- Rails: 6.1.7.4
- PostgreSQL: 14.8
- Puma: 5.6.6

You can find a full list of gems in the Gemfile.
