import Elementary
import ElementaryHTMX4

public extension HTMLAttributeValue.HTMX.HCON.Entry {
    /// `hx-sse` extension config entries, e.g. `.sse.reconnectDelay("1s")` renders `sse.reconnectDelay:1s`.
    /// Available in both `meta(htmxConfig:)` and `.hx.config(...)`.
    /// See the [hx-sse config reference](https://four.htmx.org/extensions/hx-sse#config) for more information.
    enum sse {
        public static func reconnect(_ value: Bool) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry { .init("sse.reconnect", value) }
        /// Milliseconds or a time string such as `"1s"`.
        public static func reconnectDelay(_ value: String) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry {
            .init("sse.reconnectDelay", value)
        }
        public static func reconnectMaxAttempts(_ value: Int) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry {
            .init("sse.reconnectMaxAttempts", value)
        }
        public static func pauseOnBackground(_ value: Bool) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry {
            .init("sse.pauseOnBackground", value)
        }
        /// `"immediate"`, `"first"` or `"end"`.
        public static func releaseOn(_ value: String) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry { .init("sse.releaseOn", value) }
    }
}
