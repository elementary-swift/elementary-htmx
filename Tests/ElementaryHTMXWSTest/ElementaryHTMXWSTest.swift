import Elementary
import ElementaryHTMXWS
import TestUtilities
import Testing

@Suite struct ElementaryHTMXWSTests {
    @Test func reexportsHTMX2WS() {
        HTMLAttributeAssertEqual(.ws.connect("/test"), "ws-connect", "/test")
        HTMLAttributeAssertEqual(.hx.ext(.ws), "hx-ext", "ws")
        HTMLAttributeAssertEqual(.hx.trigger(.ws("time")), "hx-trigger", "ws:time")
    }
}
