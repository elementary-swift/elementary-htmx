import Elementary
import ElementaryHTMX4
import ElementaryHTMX4SSE
import ElementaryHTMX4WS

struct Page<Content: HTML>: HTMLDocument {
    var title: String
    var config: HTMLAttributeValue.HTMX.HCON<HTMLAttributeValue.HTMX.GlobalConfig>?
    var content: Content

    init(
        _ title: String,
        config: HTMLAttributeValue.HTMX.HCON<HTMLAttributeValue.HTMX.GlobalConfig>? = nil,
        @HTMLBuilder content: () -> Content
    ) {
        self.title = title
        self.config = config
        self.content = content()
    }

    var head: some HTML {
        // htmx reads the config meta tag once, when htmx.min.js runs
        if let config {
            meta(htmxConfig: config)
        }
        script(.src("/htmx.min.js")) {}
        script(.src("/ext/hx-sse.min.js")) {}
        script(.src("/ext/hx-ws.min.js")) {}
    }

    var body: some HTML {
        content
    }
}

struct BasicPage: HTML {
    var body: some HTML {
        Page("basic") {
            button(.id("load"), .hx.get("/basic/fragment"), .hx.target("#output"), .hx.swap(.outerHTML)) { "Load" }
            div(.id("output"), .class("original")) { "Original" }

            button(
                .id("configured"),
                .hx.get("/basic/fragment"),
                .hx.target("#config-output"),
                .hx.config([.timeout("5s"), .cache("no-cache"), .sse.reconnect(false)]),
                .hx.on(":config:request", "this.dataset.request = JSON.stringify(ctx.request)")
            ) { "Configured" }
            div(.id("config-output")) {}
        }
    }
}

struct InheritancePage: HTML {
    var body: some HTML {
        Page("inheritance") {
            div(.hx.target(.inherited, "#with-output")) {
                button(.id("with-button"), .hx.get("/inheritance/fragment")) { "With :inherited" }
            }
            div(.id("with-output")) { "empty" }

            div(.hx.target("#without-output")) {
                button(.id("without-button"), .hx.get("/inheritance/fragment")) { "Without :inherited" }
            }
            div(.id("without-output")) { "empty" }

            div(.hx.vals(.inherited, #"{"tenant": "acme"}"#)) {
                button(
                    .id("append-button"),
                    .hx.get("/inheritance/vals"),
                    .hx.vals(.append, #"{"source": "button"}"#),
                    .hx.target("#append-output")
                ) { "With :append" }
            }
            div(.id("append-output")) { "empty" }
        }
    }
}

struct ImplicitInheritancePage: HTML {
    var body: some HTML {
        Page(
            "config",
            config: [
                .implicitInheritance(true),
                .init("prefix", ""),
                .noSwap(["204", "304", "4xx"]),
                .morphIgnore(["data-htmx-powered", "style"]),
                .init("custom", "a b, c"),
                .sse.reconnectDelay("1s"),
                .init("ws.reconnectCodes", [1001, 1006]),
            ]
        ) {
            div(.hx.target("#implicit-output")) {
                button(.id("implicit-button"), .hx.get("/inheritance/fragment")) { "Implicit" }
            }
            div(.id("implicit-output")) { "empty" }
        }
    }
}

struct PartialsPage: HTML {
    var body: some HTML {
        Page("partials") {
            button(.id("send"), .hx.post("/partials/fragment")) { "Send" }
            div(.id("messages")) { p { "First" } }
            span(.id("count")) { "1" }
        }
    }
}

struct PartialsFragment: HTML {
    var body: some HTML {
        hxPartial(.hx.target("#messages"), .hx.swap(.beforeEnd)) { p { "Second" } }
        hxPartial(.id("count")) { "2" }
    }
}

struct MorphPage: HTML {
    var body: some HTML {
        Page("morph") {
            button(.id("morph"), .hx.get("/morph/fragment"), .hx.target("#morph-list"), .hx.swap(.innerMorph)) { "Morph" }
            ul(.id("morph-list")) { ListItems(prefix: "morph", updated: false) }

            button(.id("replace"), .hx.get("/morph/fragment?prefix=replace"), .hx.target("#replace-list"), .hx.swap(.innerHTML)) {
                "Replace"
            }
            ul(.id("replace-list")) { ListItems(prefix: "replace", updated: false) }
        }
    }
}

struct ListItems: HTML {
    var prefix: String
    var updated: Bool

    var body: some HTML {
        li(.id("\(prefix)-1")) { updated ? "One (updated)" : "One" }
        li(.id("\(prefix)-2")) { updated ? "Two (updated)" : "Two" }
        if updated {
            li(.id("\(prefix)-3")) { "Three" }
        }
    }
}

struct SSEPage: HTML {
    var body: some HTML {
        Page("sse") {
            div(
                .id("sse"),
                .hx.sse.connect("/sse/stream"),
                .hx.sse.close("done"),
                .hx.on("htmx:sse:close", "this.dataset.closed = reason")
            ) { "Waiting" }
        }
    }
}

struct WSPage: HTML {
    var body: some HTML {
        Page("ws") {
            div(.hx.ws.connect("/ws/echo"), .hx.target("#ws-messages"), .hx.swap(.beforeEnd)) {
                div(.id("ws-messages")) {}
                form(.id("ws-form"), .hx.ws.send) {
                    input(.type(.text), .name("message"), .id("ws-input"))
                    button { "Send" }
                }
            }
        }
    }
}
