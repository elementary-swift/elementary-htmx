import Elementary
import ElementaryHTMXSSE
import TestUtilities
import Testing

@Suite struct ElementaryHTMXSSETests {
    @Test func rendersExtension() {
        HTMLAttributeAssertEqual(.hx.ext(.sse), "hx-ext", "sse")
    }

    @Test func rendersAttributes() {
        HTMLAttributeAssertEqual(.sse.connect("/test"), "sse-connect", "/test")
        HTMLAttributeAssertEqual(.sse.swap("test"), "sse-swap", "test")
        HTMLAttributeAssertEqual(.sse.close("test"), "sse-close", "test")
    }

    @Test func rendersAttributeValues() {
        HTMLAttributeAssertEqual(.hx.trigger(.sse("time")), "hx-trigger", "sse:time")
    }
}
