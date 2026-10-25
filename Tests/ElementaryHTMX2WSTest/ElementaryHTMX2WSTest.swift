import Elementary
import ElementaryHTMX2WS
import TestUtilities
import Testing

@Suite struct ElementaryHTMX2WSTests {
    @Test func rendersExtension() {
        HTMLAttributeAssertEqual(.hx.ext(.ws), "hx-ext", "ws")
    }

    @Test func rendersAttributes() {
        HTMLAttributeAssertEqual(.ws.connect("/test"), "ws-connect", "/test")
    }

    @Test func rendersAttributeValues() {
        HTMLAttributeAssertEqual(.hx.trigger(.ws("time")), "hx-trigger", "ws:time")
    }

    @Test func rendersWSSend() {
        HTMLAttributeAssertEqual(.ws.send, "ws-send", nil)
    }
}
