template tag(name: string, body: untyped): untyped =
    htmlStr.add "<" & name & ">"
    body
    htmlStr.add "</" & name & ">"

template tagParams(name: string, body: untyped): untyped =
    htmlStr.add "<" & name
    body
    htmlStr.add ">"

template html*(body: untyped) = tag("html", body)

template head*(body: untyped) = tag("head", body)

template charset*(charset: string) =
    tagParams "meta":
        htmlStr.add " charset=\"" & charset & "\""

template title*(text: string) = 
    tag "title":
        htmlStr.add text

template link*(rel, href: string) =
    tagParams "link":
        htmlStr.add " rel=\"" & rel & "\""
        htmlStr.add " href=\"" & href & "\""

template body*(body: untyped) = tag("body", body)

template h1*(text: string) = 
    tag "h1":
        htmlStr.add text

template site_heading*(page_title: string) =
    head:
        charset "utf-8"
        link(rel="stylesheet", href="/styles.css")
        title page_title