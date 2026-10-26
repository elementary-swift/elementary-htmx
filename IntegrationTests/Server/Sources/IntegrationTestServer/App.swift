import Foundation
import Hummingbird
import HummingbirdWebSocket

@main
struct App {
    static func main() async throws {
        let port = ProcessInfo.processInfo.environment["PORT"].flatMap(Int.init) ?? 8484

        let router = Router()
        let assetsURL = Bundle.module.resourcePath!.appending("/Public")
        router.middlewares.add(FileMiddleware(assetsURL, searchForIndexHtml: false))
        addRoutes(to: router)

        let wsRouter = Router(context: BasicWebSocketRequestContext.self)
        addWSRoutes(to: wsRouter)

        let app = Application(
            router: router,
            server: .http1WebSocketUpgrade(webSocketRouter: wsRouter),
            configuration: .init(address: .hostname("127.0.0.1", port: port)),
            onServerRunning: { _ in
                print("Integration test server running on http://127.0.0.1:\(port)/")
            }
        )
        try await app.runService()
    }
}
