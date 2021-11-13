# Reference

* [getx tutorial](https://www.youtube.com/watch?v=wtHBsvj2QKA&list=PLCaS22Sjc8YR32XmudgmVqs49t-eKKr9t)
* [getx pattern](https://github.com/kauemurakami/getx_pattern)

# API

{base_url_port}/api/

#### /test/all: GET, NO PARAM, NO AUTH

#### /auth/signin: POST, NO AUTH

```json
{
  "username": "?????",
  "password": "?????"
}
```

#### /auth/signup: POST, NO AUTH

```json
{
  "username": "?????",
  "password": "?????"
}
```

**RULE of signup body**

* username: len: 6-25
* password: len: 8-30, 1 upper, 1 number, 1 special char, ko whitespace

#### /auth/refreshToken: POST, NO AUTH

```json
{
  "refreshToken": "?????"
}
```

# TODO: LOGOUT

#### /prj/create: POST, AUTH

```json
{
  "name": "????"
}
```

#### /prj/listUsersInProject/{groupId}: POST, AUTH

```json
{
  "page": 0,
  "size": 10,
  "sortField": "id",
  "sortAscending": "false",
  "filter": ""
}
```

#### /prj/list: POST, AUTH

```json
{
  "page": 0,
  "size": 10,
  "sortField": "updateTime",
  "sortAscending": "false",
  "filter": ""
}
```

#### /prj/find/{id}: GET, AUTH, NO PARAM

#### /prj/rename/{projectId}: POST, AUTH
```json
"New Name"
```

#### /prj/delete/{projectId}: DELETE, AUTH


