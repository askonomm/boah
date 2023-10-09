import std/asynchttpserver
import std/asyncdispatch
import std/typetraits

type
    GET* = object
    POST* = object
    Map*[T: GET | POST] = object
        path*: string
        cb*: proc (req: Request) {.async, gcsafe.}

type
    Routes* = seq[Map]

proc route*(req: Request, routes: Routes) {.async, gcsafe.} =
    var foundRoute: proc(req: Request) {.async, gcsafe.}

    for route in routes:
        var methodMatches = false
        
        if name(route.type) == "Map[router.GET]" and req.reqMethod == HttpGet:
            methodMatches = true
        elif name(route.type) == "Map[router.POST]" and req.reqMethod == HttpPost:
            methodMatches = true

        if req.url.path == route.path and methodMatches:
            foundRoute = route.cb
            break

    if foundRoute.isNil:
        await req.respond(Http404, "Not Found")

    await foundRoute(req)