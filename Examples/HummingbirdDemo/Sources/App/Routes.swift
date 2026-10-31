import AsyncAlgorithms
import Elementary
import ElementaryHTMX4
import Foundation
import Hummingbird
import HummingbirdElementary
import HummingbirdWebSocket
import NIOWebSocket

func addRoutes(to router: Router<some RequestContext>) {
    router.get("") { _, _ in
        HTMLResponse {
            MainPage()
        }
    }

    router.get("/time") { _, _ in
        Response(
            status: .ok,
            headers: [.contentType: "text/event-stream"],
            body: .init { writer in
                for await _ in AsyncTimerSequence.repeating(every: .seconds(1)).cancelOnGracefulShutdown() {
                    try await writer.writeSSE(html: TimeHeading())
                }
                try await writer.finish(nil)
            }
        )
    }

    router.post("/items") { request, context in
        let body = try await request.decode(as: AddItemRequest.self, context: context)
        await Database.shared.addItem(body.item)

        return HTMLResponse {
            ItemList()
        }
    }

    router.delete("items/{index}") { _, context in
        guard let index = context.parameters.get("index", as: Int.self) else {
            throw HTTPError(.badRequest)
        }

        let wasRemoved = await Database.shared.removeItem(at: index)

        guard wasRemoved else {
            throw HTTPError(.notFound)
        }

        return HTMLResponse {
            // example of using OOB swaps
            ItemList()
                .attributes(.hx.swapOOB(.outerHTML, "#list"))
        }
    }
}

struct AddItemRequest: Decodable {
    var item: String
}

func addWSRoutes(to router: Router<some WebSocketRequestContext>) {
    router.ws("echo") { _, _ in
        .upgrade([:])
    } onUpgrade: { inbound, outbound, _ in
        for try await input in inbound.messages(maxSize: 1_000_000) {
            guard case let .text(text) = input else { continue }
            let echoRequest = try JSONDecoder().decode(EchoRequest.self, from: text.data(using: .utf8)!)
            try await outbound.write(.text(WSResponse(echoRequest: echoRequest).render()))
        }
    }
}

struct EchoRequest: Codable {
    var message: String
}

extension ResponseBodyWriter {
    mutating func writeSSE(event: String? = nil, html: some HTML) async throws {
        if let event {
            try await write(ByteBuffer(string: "event: \(event)\n"))
        }
        try await write(ByteBuffer(string: "data: "))
        try await writeHTML(html)
        try await write(ByteBuffer(string: "\n\n"))
    }
}
