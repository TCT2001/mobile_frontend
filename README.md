# Reference

"username": "tct@2001.com",
"password": "Tct@2001" or "tuyen331"

background image:  ![computer_girl_by_abbottcreations_d882cw1-fullview](https://user-images.githubusercontent.com/81580234/144733496-704997c2-5461-4a12-9dc9-8cc8b3971aa0.jpg)
Splash:

![Best](https://user-images.githubusercontent.com/81580234/144733465-56f0ef2b-4201-48f0-8e90-fd7ecaa28d27.gif)

http://unicode.org/Public/emoji/1.0/emoji-data.txt 

https://blog.waldo.io/flutter-card/

Ctrl + .

Several Splash: 
![J59](https://user-images.githubusercontent.com/81580234/144733422-203d405b-c0ed-45b8-aad5-0691d8d50db8.gif)
![VJl](https://user-images.githubusercontent.com/81580234/144733432-3287a883-5f49-4a40-accb-dc305ecf747a.gif)

- https://stackoverflow.com/questions/60285825/dart-cannot-convert-listdynamic-to-listmapstring-dynamic-despite-cast
- https://stackoverflow.com/questions/55150329/flutter-searchdelegate-on-search-i-have-to-make-api-after-getting-response-i

- https://stackoverflow.com/questions/57351054/flutter-pass-search-data-to-searchdelegate

- [getx tutorial](https://www.youtube.com/watch?v=wtHBsvj2QKA&list=PLCaS22Sjc8YR32XmudgmVqs49t-eKKr9t)
- [getx pattern](https://github.com/kauemurakami/getx_pattern)


https://www.flutterclutter.dev/flutter/tutorials/how-to-add-a-border-to-a-widget/2020/587/
# Settings

- Signout
- Info: Thông tin về ứng dụng
- Đổi mật khẩu
- Bật tắt thông báo

# API

- {base_url_port}/api/

- ???: required rỗng: optional
- Helper

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

- username: len: 6-25
- password: len: 8-30, 1 upper, 1 number, 1 special char, ko whitespace

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
