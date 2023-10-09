import norm/model
import norm/sqlite
import norm/pool
import std/times
import os

type
    User = ref object of Model
        email: string
        password: string
        auth_token: string
        reset_token: string

proc newUser (): User =
    User(email: "", password: "", auth_token: "", reset_token: "")

type 
    Post = ref object of Model
        title: string
        slug: string
        content: string
        author: User
        published: bool
        published_at: DateTime
        created_at: DateTime
        updated_at: DateTime

proc newPost (): Post =
    Post(
        title: "", 
        slug: "", 
        content: "", 
        author: newUser(), 
        published: false, 
        published_at: now(), 
        created_at: now(), 
        updated_at: now())
        
putEnv("DB_HOST", "db.sqlite3")

var connPool = newPool[DbConn](10)

proc initDb* () =
    echo "Initializing DB"
    withDb(connPool):
        db.createTables(newUser())
        db.createTables(newPost())