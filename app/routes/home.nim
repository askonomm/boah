import ../../http
import ../../templates
import std/asynchttpserver
import std/asyncdispatch

proc home* (req: Request) {.async, gcsafe.} =
    var htmlStr = ""

    html:
        site_heading(page_title="Home")
        body:
            h1 "Hello, world!"

    await req.html(htmlStr)
