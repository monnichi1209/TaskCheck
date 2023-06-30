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
