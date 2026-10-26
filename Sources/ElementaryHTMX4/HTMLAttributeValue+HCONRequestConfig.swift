import Elementary

public extension HTMLAttributeValue.HTMX.HCON.Entry where Scope == HTMLAttributeValue.HTMX.RequestConfig {
    /// A time string such as `"5s"`, or milliseconds.
    static func timeout(_ value: String) -> Self { .init("timeout", value) }
    /// `"omit"`, `"same-origin"` or `"include"`.
    static func credentials(_ value: String) -> Self { .init("credentials", value) }
    /// A fetch cache mode, e.g. `"no-cache"`.
    static func cache(_ value: String) -> Self { .init("cache", value) }
    /// `"follow"`, `"error"` or `"manual"`.
    static func redirect(_ value: String) -> Self { .init("redirect", value) }
    /// A referrer URL or `"no-referrer"`.
    static func referrer(_ value: String) -> Self { .init("referrer", value) }
    static func integrity(_ value: String) -> Self { .init("integrity", value) }
    static func validate(_ value: Bool) -> Self { .init("validate", value) }
}
