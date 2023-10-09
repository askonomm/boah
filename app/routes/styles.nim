import ../../http
import std/asynchttpserver
import std/asyncdispatch

const stylesContents = staticRead"../styles.css"

proc styles* (req: Request) {.async, gcsafe.} =
    await req.css(stylesContents)