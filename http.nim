import std/asynchttpserver
import std/asyncdispatch

proc html* (req: Request, html: string) {.async, gcsafe.} =
    let headers = {"Content-Type": "text/html; charset=utf-8"}
    await req.respond(Http200, html, headers.newHttpHeaders())

proc css* (req: Request, css: string) {.async, gcsafe.} =
    let headers = {"Content-Type": "text/css; charset=utf-8"}
    await req.respond(Http200, css, headers.newHttpHeaders())