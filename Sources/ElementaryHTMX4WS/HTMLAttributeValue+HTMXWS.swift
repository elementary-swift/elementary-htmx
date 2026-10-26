import Elementary
import ElementaryHTMX4

public extension HTMLAttributeValue.HTMX.HCON.Entry {
    /// `hx-ws` extension config entries, e.g. `.ws.reconnectDelay("1s")` renders `ws.reconnectDelay:1s`.
    /// Available in both `meta(htmxConfig:)` and `.hx.config(...)`.
    /// See the [hx-ws config reference](https://four.htmx.org/extensions/hx-ws#config) for more information.
    enum ws {
        public static func reconnect(_ value: Bool) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry { .init("ws.reconnect", value) }
        /// Milliseconds or a time string such as `"1s"`.
        public static func reconnectDelay(_ value: String) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry {
            .init("ws.reconnectDelay", value)
        }
        public static func reconnectMaxAttempts(_ value: Int) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry {
            .init("ws.reconnectMaxAttempts", value)
        }
        public static func pauseOnBackground(_ value: Bool) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry {
            .init("ws.pauseOnBackground", value)
        }
        public static func protocols(_ value: [String]) -> HTMLAttributeValue.HTMX.HCON<Scope>.Entry { .init("ws.protocols", value) }
    }
}
