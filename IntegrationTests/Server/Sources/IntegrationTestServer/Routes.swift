import Elementary
import ElementaryHTMX4
import Foundation
import Hummingbird
import HummingbirdElementary
import HummingbirdWebSocket

func addRoutes(to router: Router<some RequestContext>) {
    router.get("/health") { _, _ in "ok" }

    router.get("/basic") { _, _ in HTMLResponse { BasicPage() } }
    router.get("/basic/fragment") { _, _ in
        HTMLResponse { div(.id("output"), .class("swapped")) { "Swapped" } }
    }

    router.get("/inheritance") { _, _ in HTMLResponse { InheritancePage() } }
    router.get("/inheritance/implicit") { _, _ in HTMLResponse { ImplicitInheritancePage() } }
    router.get("/inheritance/fragment") { _, _ in
        HTMLResponse { span(.class("fragment")) { "Fragment" } }
    }
    router.get("/inheritance/vals") { request, _ in
        let tenant = request.uri.queryParameters["tenant"].map(String.init) ?? "-"
        let source = request.uri.queryParameters["source"].map(String.init) ?? "-"
        return HTMLResponse { "tenant=\(tenant) source=\(source)" }
    }

    router.get("/partials") { _, _ in HTMLResponse { PartialsPage() } }
    router.post("/partials/fragment") { _, _ in HTMLResponse { PartialsFragment() } }

    router.get("/morph") { _, _ in HTMLResponse { MorphPage() } }
    router.get("/morph/fragment") { request, _ in
        let prefix = request.uri.queryParameters["prefix"].map(String.init) ?? "morph"
        return HTMLResponse { ListItems(prefix: prefix, updated: true) }
    }

    router.get("/sse") { _, _ in HTMLResponse { SSEPage() } }
    router.get("/sse/stream") { _, _ in
        Response(
            status: .ok,
            headers: [.contentType: "text/event-stream", .cacheControl: "no-cache"],
            body: .init { writer in
                try await writer.write(ByteBuffer(string: "data: "))
                try await writer.writeHTML(p(.id("sse-message")) { "Hello from SSE" })
                try await writer.write(ByteBuffer(string: "\n\n"))
                try await writer.write(ByteBuffer(string: "event: done\ndata: bye\n\n"))
                try await writer.finish(nil)
            }
        )
    }

    router.get("/ws") { _, _ in HTMLResponse { WSPage() } }
}

func addWSRoutes(to router: Router<some WebSocketRequestContext>) {
    router.ws("/ws/echo") { _, _ in
        .upgrade([:])
    } onUpgrade: { inbound, outbound, _ in
        try await outbound.write(.text(p(.id("ws-connected")) { "connected" }.render()))

        for try await input in inbound.messages(maxSize: 1_000_000) {
            guard case let .text(text) = input else { continue }
            let message = try JSONDecoder().decode(WSMessage.self, from: Data(text.utf8))
            try await outbound.write(.text(p(.class("ws-echo")) { "echo: \(message.message)" }.render()))
        }
    }
}

/// The JSON that `hx-ws:send` sends: form values plus reserved `headers` metadata.
struct WSMessage: Decodable {
    var message: String
    var headers: [String: String]
}
