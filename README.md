<<<<<<< HEAD
# Reference

Ctrl + .
=======
# mobile_app, #Cyber_Team's_product

App quản lý công việc từ xa dành cho tổ chức, doanh nghiệp.
Thành viên team:
Vũ Minh Tuyến (Nhóm trưởng)
Trần Vũ Toàn
Trần Minh Ngọc
Nguyễn Văn Thành
>>>>>>> origin/thanh

* [getx tutorial](https://www.youtube.com/watch?v=wtHBsvj2QKA&list=PLCaS22Sjc8YR32XmudgmVqs49t-eKKr9t)
* [getx pattern](https://github.com/kauemurakami/getx_pattern)

<<<<<<< HEAD
# API

* {base_url_port}/api/

* ???: required rỗng: optional
* Helper
```java
public class PaginateParam {
    public static final int DEFAULT_PAGE_SIZE = 10;
    protected int page = 0;
    protected int size = DEFAULT_PAGE_SIZE;
    protected String sortField;
    protected boolean sortAscending;
    protected String filter = "";

    public void setSortAscending(String sortAscending) {
        this.sortAscending = Boolean.parseBoolean(sortAscending);
    }

    public void setSize(int size) {
        if (size > 0) {
            this.size = size;
        }
    }
}

public enum VisibleTaskScope {
    PUBLIC,
    // some user can have this task
    PRIVATE
}

public enum Priority {
    CRITICAL,
    MAJOR,
    NORMAL,
    MINOR
}

public enum TaskState {
    SUBMITTED,
    IN_PROCESS,
    INCOMPLETE,
    TO_BE_DISCUSSED,
    DONE,
    DUPLICATE,
    OBSOLETE,
}
```

#### /test/all: GET, NO PARAM, NO AUTH

#### /test/feedback: POST, NO AUTH
```json
{
  "userId": "",
  "content: "???"
}
```

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
Body: PaginateParam

#### /prj/list: POST, AUTH
Body: PaginateParam

#### /prj/find/{id}: GET, AUTH, NO PARAM

#### /prj/rename/{projectId}: POST, AUTH

```json
"???? <New Name>"
```

#### /prj/delete/{projectId}: DELETE, AUTH

#### /task/create: POST, AUTH
```json
{
  "name": "New Task",
  "content": "",
  "visibleTaskScope": "PUBLIC",
  "priority": "NORMAL",
  "taskState": "SUBMITTED",
  "project": {
    "id": "???"
  },
  "userIdIfVisibleIsPrivate": []
}
```

#### /task/list/{projectId}: POST, AUTH
Body: PaginateParam

#### /task/find/{id}: GET, AUTH

#### /task/update/content/{taskId}: PUT, AUTH
```json
"???? <New Content>"
```

#### /task/rename/{taskId}: PUT, AUTH
```json
"???? <New Name>"
```

#### /task/update/state/{taskId}: PUT, AUTH
```json
{
  "taskState": "???"
}
```

#### /task/delete/{taskId}: DELETE, AUTH
=======

#Flow:
![Flow](https://user-images.githubusercontent.com/81580234/141955368-dd03ffca-a31d-4f82-880c-8c19e4f69f8e.PNG)

#Demo (Vì máy mình chạy máy ảo hơi lag nên mình dùng chrome sau đó để định dạng mobile)

1. Home:
![home](https://user-images.githubusercontent.com/81580234/141954700-a414a8cd-7142-4c1b-ad54-36ad102c94ec.PNG)

2. Login:
![Login](https://user-images.githubusercontent.com/81580234/141954763-7ee49ebe-8e1a-41f4-8f1f-c8f2bab08561.PNG)

3. Signup:
![Signup](https://user-images.githubusercontent.com/81580234/141954778-7aa01dc7-e1e9-4e6f-843e-97ba4d8ec08c.PNG)

4. Neo:
![neo](https://user-images.githubusercontent.com/81580234/141954807-6c7d7c6e-3516-43ee-993d-805771264a5d.PNG)

5.Logo:
![Logo](https://user-images.githubusercontent.com/81580234/141954846-1e7ff91b-9954-4c58-bb9c-7e98046890ff.png)



>>>>>>> origin/thanh
