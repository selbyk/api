### Division

This is a very simple API for testing clients. It has two resources that you can manipulate: **Users** and **Posts**.

#### Basics

- Users have a `username`, `email`, and `password`.
- Users may have `followers` and be `following` any number of users.
- Posts belong to a user and simply have a `content` field.

#### Routes of Interest

```
GET /posts
All of the posts created by all users.

GET /users
All of the users in the database.

POST /users
Create a new user.

GET /users/:username/posts
The posts created by a specific user.

POST /users/:username/posts
(Requires API Key) Create a new post for a specific user.

POST /authenticate
Give a valid username and password and receive that user's API key.
```

#### User Authentication

- In leu of user sessions, all users are given an **API Key** on creation which they can then use to access resources.
- If a user wants to, for instance, create a new post, it must supply it's API key in the request in order for it to be processed.
- Users can obtain their API key by `POST`ing to `/authenticate` with their username and password.
