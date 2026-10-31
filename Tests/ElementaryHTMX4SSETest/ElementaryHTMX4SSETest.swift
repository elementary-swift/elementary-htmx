import Elementary
import ElementaryHTMX4
import ElementaryHTMX4SSE
import TestUtilities
import Testing

@Suite struct ElementaryHTMX4SSETests {
    @Test func rendersAttributes() {
        HTMLAttributeAssertEqual(.hx.sse.connect("/events"), "hx-sse:connect", "/events")
        HTMLAttributeAssertEqual(.hx.sse.close("done"), "hx-sse:close", "done")
    }

    @Test func rendersNamedEventTrigger() {
        HTMLAttributeAssertEqual(.hx.trigger(.event("progress"), [.from("body")]), "hx-trigger", "progress from:body")
    }

    @Test func rendersConfigEntries() {
        let config: HCONValue<HCONScope.GlobalConfig> = [
            .sse.reconnect(false),
            .sse.reconnectDelay("1s"),
            .sse.reconnectMaxAttempts(5),
            .sse.pauseOnBackground(false),
            .sse.releaseOn("first"),
        ]
        #expect(
            config.rawValue
                == "sse.reconnect:false sse.reconnectDelay:1s sse.reconnectMaxAttempts:5 sse.pauseOnBackground:false sse.releaseOn:first"
        )
    }

    @Test func rendersRequestConfigEntries() {
        HTMLAttributeAssertEqual(
            .hx.config([.sse.reconnect(false), .sse.reconnectMaxAttempts(2)]),
            "hx-config",
            "sse.reconnect:false sse.reconnectMaxAttempts:2"
        )
    }
}
