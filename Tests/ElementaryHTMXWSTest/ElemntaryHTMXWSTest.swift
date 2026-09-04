import Elementary
import ElementaryHTMXWS
import TestUtilities
import Testing

@Suite struct ElementaryHTMXWSTests {
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
