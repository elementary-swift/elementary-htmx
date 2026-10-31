import Elementary
import ElementaryHTMX4
import ElementaryHTMX4WS
import TestUtilities
import Testing

@Suite struct ElementaryHTMX4WSTests {
    @Test func rendersAttributes() {
        HTMLAttributeAssertEqual(.hx.ws.connect("/chat"), "hx-ws:connect", "/chat")
    }

    @Test func rendersWSSend() {
        HTMLAttributeAssertEqual(.hx.ws.send, "hx-ws:send", nil)
    }

    @Test func rendersConfigEntries() {
        let config: HCONValue<HCONScope.GlobalConfig> = [
            .ws.reconnect(true),
            .ws.reconnectDelay("500"),
            .ws.reconnectMaxAttempts(3),
            .ws.pauseOnBackground(true),
            .ws.protocols(["graphql-transport-ws"]),
        ]
        #expect(
            config.rawValue
                == #"ws.reconnect:true ws.reconnectDelay:500 ws.reconnectMaxAttempts:3 ws.pauseOnBackground:true ws.protocols:'["graphql-transport-ws"]'"#
        )
    }

    @Test func rendersRequestConfigEntries() {
        HTMLAttributeAssertEqual(
            .hx.config([.ws.reconnect(false), .ws.protocols(["graphql-transport-ws"])]),
            "hx-config",
            #"ws.reconnect:false ws.protocols:'["graphql-transport-ws"]'"#
        )
    }
}
