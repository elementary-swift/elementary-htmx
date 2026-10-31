import Elementary
import ElementaryHTMX4

public extension HCONScope {
    /// Scopes that accept `.ws` options: `meta(htmxConfig:)` and `.hx.config(...)`.
    protocol WSConfig {}
}

extension HCONScope.GlobalConfig: HCONScope.WSConfig {}
extension HCONScope.RequestConfig: HCONScope.WSConfig {}

public extension HCONValue.Entry where Scope: HCONScope.WSConfig {
    /// `hx-ws` extension config entries, e.g. `.ws.reconnectDelay("1s")` renders `ws.reconnectDelay:1s`.
    /// Available in both `meta(htmxConfig:)` and `.hx.config(...)`.
    /// See the [hx-ws config reference](https://four.htmx.org/extensions/hx-ws#config) for more information.
    enum ws {
        @inlinable
        public static func reconnect(_ value: Bool) -> HCONValue<Scope>.Entry { .init("ws.reconnect", value) }
        /// Milliseconds or a time string such as `"1s"`.
        @inlinable
        public static func reconnectDelay(_ value: String) -> HCONValue<Scope>.Entry {
            .init("ws.reconnectDelay", value)
        }
        @inlinable
        public static func reconnectMaxAttempts(_ value: Int) -> HCONValue<Scope>.Entry {
            .init("ws.reconnectMaxAttempts", value)
        }
        @inlinable
        public static func pauseOnBackground(_ value: Bool) -> HCONValue<Scope>.Entry {
            .init("ws.pauseOnBackground", value)
        }
        @inlinable
        public static func protocols(_ value: [String]) -> HCONValue<Scope>.Entry { .init("ws.protocols", value) }
    }
}
