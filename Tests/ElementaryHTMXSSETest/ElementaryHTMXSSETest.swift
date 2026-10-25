import Elementary
import ElementaryHTMXSSE
import TestUtilities
import Testing

@Suite struct ElementaryHTMXSSETests {
    @Test func reexportsHTMX2SSE() {
        HTMLAttributeAssertEqual(.sse.connect("/test"), "sse-connect", "/test")
        HTMLAttributeAssertEqual(.hx.ext(.sse), "hx-ext", "sse")
        HTMLAttributeAssertEqual(.hx.trigger(.sse("time")), "hx-trigger", "sse:time")
    }
}
