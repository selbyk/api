### Koan

This is a very simple API for testing clients. It has two resources that you can manipulate: Users and Posts.

- Users have a username, email, and password.
- Users may have followers and be following any number of users.
- Posts belong to a user and simply have a content field.

Look at the routes to get an idea of what the API endpoints are.

- In leu of user sessions, all users are given an API Key on creation which they can then use to access resources.
- If a user wants to, for instance, create a new post, it must supply it's API key in the request in order for it to be processed.
- Users can obtain their API key by POSTing to "/authenticate" with their username and password.