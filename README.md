

https://www.udemy.com/course/flutter-test-driven-development-with-clean-architecture/

## Run fake backend

- 1. Instalation. (You need node installed to run npm)
```bash
npm install -g json-server
```
- 2. Run json-server
```bash
json-server --watch backend/db.json --port 3000
```
- 3. Run on your browser
```bash
http://localhost:3000/users
```

- GET /users — fetch all users
- GET /users/:id — fetch a user by id
- POST /users — create a new user
- PUT /users/:id — update a user by id
- DELETE /users/:id — delete a user by id
