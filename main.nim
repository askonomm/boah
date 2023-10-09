import router
import app/routes/home as home_route
import app/routes/styles as styles_route
import std/asynchttpserver
import std/asyncdispatch
import db

const routes = @[
    router.Map[router.GET](path: "/", cb: home_route.home),
    router.Map[router.GET](path: "/styles.css", cb: styles_route.styles),
]

proc main {.async.} =
    db.initDb()

    var server = newAsyncHttpServer()

    server.listen(Port(8090))

    while true:
        if server.shouldAcceptRequest():
            echo "Accepting request on 8090"
            await server.acceptRequest(proc (req: Request) {.async, gcsafe.} =
                await router.route(req, routes))
        else:
            echo "too many connections, sleeping"
            await sleepAsync(100)

waitFor main()
