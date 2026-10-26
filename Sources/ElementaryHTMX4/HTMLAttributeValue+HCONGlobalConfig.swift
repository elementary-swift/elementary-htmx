import Elementary

public extension HTMLAttributeValue.HTMX.HCON.Entry where Scope == HTMLAttributeValue.HTMX.GlobalConfig {
    static func transitions(_ value: Bool) -> Self { .init("transitions", value) }
    static func history(_ value: Bool) -> Self { .init("history", value) }
    /// `"reload"` does a full page reload on history navigation.
    static func history(_ value: String) -> Self { .init("history", value) }
    static func mode(_ value: String) -> Self { .init("mode", value) }
    static func defaultSwap(_ value: HTMLAttributeValue.HTMX.SwapTarget) -> Self { .init("defaultSwap", value.rawValue) }
    static func allowEmptySwapAfterOOB(_ value: Bool) -> Self { .init("allowEmptySwapAfterOOB", value) }
    static func includeIndicatorCSS(_ value: Bool) -> Self { .init("includeIndicatorCSS", value) }
    /// In milliseconds.
    static func defaultTimeout(_ value: Int) -> Self { .init("defaultTimeout", value) }
    /// A comma-separated list of extension names, e.g. `"sse,ws"`.
    static func extensions(_ value: String) -> Self { .init("extensions", value) }
    static func morphIgnore(_ value: [String]) -> Self { .init("morphIgnore", value) }
    /// Status codes and patterns, e.g. `["204", "304", "4xx", "5xx"]`.
    static func noSwap(_ value: [String]) -> Self { .init("noSwap", value) }
    static func implicitInheritance(_ value: Bool) -> Self { .init("implicitInheritance", value) }
    static func inlineScriptNonce(_ value: String) -> Self { .init("inlineScriptNonce", value) }
}
