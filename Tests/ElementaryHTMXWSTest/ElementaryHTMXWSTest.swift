import Elementary
import ElementaryHTMXWS
import TestUtilities
import Testing

@Suite struct ElementaryHTMXWSTests {
    @Test func reexportsHTMX2WS() {
        HTMLAttributeAssertEqual(.ws.connect("/test"), "ws-connect", "/test")
    }
}
