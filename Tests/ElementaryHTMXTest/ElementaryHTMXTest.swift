import Elementary
import ElementaryHTMX
import TestUtilities
import Testing

@Suite struct ElementaryHTMXTests {
    @Test func reexportsHTMX2() {
        HTMLAttributeAssertEqual(.hx.get("/test"), "hx-get", "/test")
    }
}
