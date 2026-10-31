import Elementary
import ElementaryHTMX4

public extension HCONScope {
    /// Scopes that accept `.sse` options: `meta(htmxConfig:)` and `.hx.config(...)`.
    protocol SSEConfig {}
}

extension HCONScope.GlobalConfig: HCONScope.SSEConfig {}
extension HCONScope.RequestConfig: HCONScope.SSEConfig {}

public extension HCONValue.Entry where Scope: HCONScope.SSEConfig {
    /// `hx-sse` extension config entries, e.g. `.sse.reconnectDelay("1s")` renders `sse.reconnectDelay:1s`.
    /// Available in both `meta(htmxConfig:)` and `.hx.config(...)`.
    /// See the [hx-sse config reference](https://four.htmx.org/extensions/hx-sse#config) for more information.
    enum sse {
        @inlinable
        public static func reconnect(_ value: Bool) -> HCONValue<Scope>.Entry { .init("sse.reconnect", value) }
        /// Milliseconds or a time string such as `"1s"`.
        @inlinable
        public static func reconnectDelay(_ value: String) -> HCONValue<Scope>.Entry {
            .init("sse.reconnectDelay", value)
        }
        @inlinable
        public static func reconnectMaxAttempts(_ value: Int) -> HCONValue<Scope>.Entry {
            .init("sse.reconnectMaxAttempts", value)
        }
        @inlinable
        public static func pauseOnBackground(_ value: Bool) -> HCONValue<Scope>.Entry {
            .init("sse.pauseOnBackground", value)
        }
        /// `"immediate"`, `"first"` or `"end"`.
        @inlinable
        public static func releaseOn(_ value: String) -> HCONValue<Scope>.Entry { .init("sse.releaseOn", value) }
    }
}
