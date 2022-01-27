
# LMS




## Development

To test the app the best option is to use Docker since it sets all the environment variables and requirements.

First create a file for environment variables inspired on our sample

```bash
cp .env.docker.sample .env.docker
```

Then, run build to create the app image

```bash
docker-compose build
```

You could run `docker-compose up` or enter the container bash to develop, run rspec, rubocop, and other commands.

```bash
docker-compose run --service-ports --rm web bash 
```

Remember to run `bin/setup` to set up the database and seed it with `rails db:seed`


## Major tools

- Ruby (v3.1.0)
- Rails (v7.0.1)
- Devise (v4.8.1)
- PostgreSQL (v14.1)
- GitHub Actions
## Future Features

- [ ] Better API Standardization
- [ ] Content could be and HTML page, audio, and other types
## API Doc

To consume the API first you need to create an Admin or User and log in

This step is not necessary if you seed the database since there's already two users created

```
Admin
email: admin@admin.com
password: 12345678

User
email: user@user.com
password: 12345678
```

### Headers

Some headers are not optional and most actions require an `Authorization` header

Use `accept` headers for all actions with `application/json`

### Register users

```http
POST /api/sign_up
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `name` | `string` | header | **Required** Name of the user |
| `email` | `string` | header | **Required** Email of the user |
| `password` | `string` | header | **Required** Password of the user |

#### Code sample

```shell
curl \
  -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  http://localhost:3000/api/sign_up \
  -d '{"email":"jane.doe@mail.com","name":"Jane Doe","password":"12345678"}'
```

#### Response

```
Status: 201
```

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2LCJleHAiOjE2NDQxOTM0OTJ9.QBJRFNTESbEJXbi_QwV35EWJkvz705X3LdGWcrOmcts"
}
```

### User sign in

```http
POST /api/sign_in
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `email` | `string` | header | **Required** Email of the user |
| `password` | `string` | header | **Required** Password of the user |

#### Code sample

```shell
curl \
  -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  http://localhost:3000/api/sign_in \
  -d '{"email":"admin@admin.com","password":"12345678"}'
```

#### Response

```
Status: 200
```

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2LCJleHAiOjE2NDQxOTM0OTJ9.QBJRFNTESbEJXbi_QwV35EWJkvz705X3LdGWcrOmcts"
}
```

### List courses

To access this route user must be an admin

```http
GET /api/v1/courses
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required**. Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |

#### Code sample

```shell
curl \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses
```

#### Response

```
Status: 200
```

```json
[
  {
    "id": 1,
    "title": "Law 458",
    "description":"Cupiditate veniam recusandae sunt.",
    "created_at": "2022-01-22T20:12:22.861Z",
    "updated_at": "2022-01-22T20:12:22.861Z"
  },
  {
    "id": 2,
    "title": "Psychology 537",
    "description": "Dolorem id dolores dolor.",
    "created_at": "2022-01-22T20:12:22.867Z",
    "updated_at": "2022-01-22T20:12:22.867Z"
  }
]
```

### Get a course

To access this route user must be an admin

```http
GET /api/v1/courses/{id}
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required**. Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |
| `id` | `integer` | path |  |

#### Code sample

```shell
curl \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses/1
```

#### Response

```
Status: 200
```

```json
{
  "id": 1,
  "title": "Law 458",
  "description": "Cupiditate veniam recusandae sunt.",
  "created_at": "2022-01-22T20:12:22.861Z",
  "updated_at": "2022-01-22T20:12:22.861Z"
}
```

### Create a course

To access this route user must be an admin

```http
POST /api/v1/courses
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required**. Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |
| `title` | `string` | body | **Required**. The title of the new course |
| `description` | `string` | body | **Required**. The description of the new course |

#### Code sample

```shell
curl \
  -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses \
  -d '{"title":"Law 458","description":"Cupiditate veniam recusandae sunt."}'
```

#### Response

```
Status: 201
```

```json
{
  "id": 1,
  "title": "Law 458",
  "description": "Cupiditate veniam recusandae sunt.",
  "created_at": "2022-01-22T20:12:22.861Z",
  "updated_at": "2022-01-22T20:12:22.861Z"
}
```

### List users

To access this route user must be an admin

```http
GET /api/v1/users
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |

#### Code sample

```shell
curl \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/users
```

#### Response

```
Status: 200
```

```json
[
  {
    "id": 1,
    "email": "abraham@swift.net",
    "name": "Mina Rowe",
    "created_at": "2022-01-22T20:12:22.861Z",
    "updated_at": "2022-01-22T20:12:22.861Z"
  },
  {
    "id": 2,
    "email": "denver@simonis.name",
    "name": "Blair Huels",
    "created_at": "2022-01-22T20:12:22.867Z",
    "updated_at": "2022-01-22T20:12:22.867Z"
  }
]
```

### Get a user

To access this route user must be an admin

```http
GET /api/v1/users/{id}
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |
| `id` | `integer` | path |  |

#### Code sample

```shell
curl \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/users/1
```

#### Response

```
Status: 200
```

```json
{
  "id": 1,
  "email": "abraham@swift.net",
  "name": "Mina Rowe",
  "created_at": "2022-01-22T20:12:22.861Z",
  "updated_at": "2022-01-22T20:12:22.861Z"
}
```

### Create a user

To access this route user must be an admin

```http
POST /api/v1/users
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |
| `email` | `string` | body | **Required** The email of the new user |
| `name` | `string` | body | **Required** The name of the new user |

#### Code sample

```shell
curl \
  -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/users \
  -d '{"email":"jane.doe@mail.com","name":"Jane Doe"}'
```

#### Response

```
Status: 201
```

```json
{
  "id": 1,
  "email": "jane.doe@mail.com",
  "name": "Jane Doe",
  "created_at": "2022-01-22T20:12:22.861Z",
  "updated_at": "2022-01-22T20:12:22.861Z"
}
```

### Register Content

To access this route user must be an admin

Use could use `accept` or `Content-Type` headers

```http
POST /api/v1/courses/{course_id}/contents
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | Set to 'application/json' |
| `Content-Type` | `string` | header | Set to 'multipart/form-data' |
| `Authentication` | `string` | header | **Required** Authentication token |
| `name` | `string` | body | **Required** Name of the content |
| `file` | `file` | body | File to be uploaded |

#### Code sample

```shell
curl \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses/1/contents \
  -F "file=@spec/fixtures/files/dramatic_chipmunk.mp4" \
  -F "name=Lorem"
```

#### Response

```
Status: 201
```

```json
{
  "id": 1,
  "name": "Lorem",
  "course_id": 1,
  "created_at": "2022-01-27T02:13:05.905Z",
  "updated_at": "2022-01-27T02:13:05.922Z"
}
```

### Remove Content

To access this route user must be an admin

```http
DELETE /api/v1/contents/{content_id}
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |

#### Code sample

```shell
curl \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/contents/1
```

#### Response

```
Status: 204
```

### Register audiences

```http
POST /api/v1/courses/{course_id}/audiences
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |

#### Code sample

```shell
curl \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses/1/audiences
```

#### Response

```
Status: 201
```

```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "created_at": "2022-01-27T23:39:35.661Z",
  "updated_at": "2022-01-27T23:39:35.661Z"
}
```

### List Audiences

Only admin can access this route

```http
GET /api/v1/courses/{course_id}/audiences/{user_id}
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |

#### Code sample

```shell
curl \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses/1/audiences
```

#### Response

```
Status: 200
```

```json
[
  {
    "id": 1,
    "course_id": 1,
    "user_id": 1,
    "created_at": "2022-01-27T23:39:35.661Z",
    "updated_at": "2022-01-27T23:39:35.661Z"
  }
]
```

### Remove Audience

Only admins can access this route

```http
DELETE /api/v1/courses/{course_id}/audiences/{user_id}
```

#### Parameters

| Name | Type | In | Description |
| :--- | :--- | :---| :--- |
| `accept` | `string` | header | **Required** Set to 'application/json' |
| `Authentication` | `string` | header | **Required** Authentication token |

#### Code sample

```shell
curl \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: [TOKEN]" \
  http://localhost:3000/api/v1/courses/1/audiences/1
```

#### Response

```
Status: 204
```
