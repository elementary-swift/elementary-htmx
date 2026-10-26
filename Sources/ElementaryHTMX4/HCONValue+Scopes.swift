import Elementary

/// The scopes of ``HCONValue``, one for each place htmx reads HCON.
public enum HCONScope {
    /// The global htmx config in `meta(htmxConfig:)`.
    /// See the [htmx config reference](https://four.htmx.org/reference/config/htmx-config).
    public enum GlobalConfig {}

    /// Per-request config in `.hx.config(...)`.
    /// See the [hx-config reference](https://four.htmx.org/reference/attributes/hx-config).
    public enum RequestConfig {}

    /// `hx-swap` modifiers, e.g. `.hx.swap(.outerHTML, [.transition(true)])`.
    /// See the [hx-swap reference](https://four.htmx.org/reference/attributes/hx-swap#modifiers).
    public enum SwapModifiers {}

    /// `hx-trigger` modifiers, e.g. `.hx.trigger(.event(.click), [.once, .delay("1s")])`.
    /// See the [hx-trigger reference](https://four.htmx.org/reference/attributes/hx-trigger#event-modifiers).
    public enum TriggerModifiers {}

    /// Scopes that override the swap with `swap`, `target` and `select` entries.
    public protocol SwapOverride {}

    /// `.hx.status(code, [...])`.
    /// See the [hx-status reference](https://four.htmx.org/reference/attributes/hx-status#modifiers).
    public enum StatusOverrides: SwapOverride {}

    /// `.hx.boost([...])`.
    /// See the [hx-boost reference](https://four.htmx.org/reference/attributes/hx-boost#advanced-syntax).
    public enum BoostConfig: SwapOverride {}

    /// `.hx.vals([...])` and `.hx.headers([...])`. Only `.init(key, value)` entries.
    /// htmx parses values like `2` or `true` as numbers and booleans.
    public enum Values {}
}

// MARK: GlobalConfig

public extension HCONValue.Entry where Scope == HCONScope.GlobalConfig {
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

// MARK: RequestConfig

public extension HCONValue.Entry where Scope == HCONScope.RequestConfig {
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

// MARK: SwapModifiers

public extension HCONValue.Entry where Scope == HCONScope.SwapModifiers {
    static func transition(_ value: Bool) -> Self { .init("transition", value) }
    /// A delay before the swap, e.g. `"1s"`.
    static func swap(_ duration: String) -> Self { .init("swap", duration) }
    /// A delay between swap and settle, e.g. `"10ms"`.
    static func settle(_ duration: String) -> Self { .init("settle", duration) }
    static func ignoreTitle(_ value: Bool) -> Self { .init("ignoreTitle", value) }
    static func strip(_ value: Bool) -> Self { .init("strip", value) }
    static func focusScroll(_ value: Bool) -> Self { .init("focusScroll", value) }
    static func swapEmpty(_ value: Bool) -> Self { .init("swapEmpty", value) }
    static func scroll(_ value: HTMLAttributeValue.HTMX.ScrollModifier) -> Self { .init("scroll", value.rawValue) }
    static func scrollTarget(_ selector: String) -> Self { .init("scrollTarget", selector) }
    static func show(_ value: HTMLAttributeValue.HTMX.ScrollModifier) -> Self { .init("show", value.rawValue) }
    static func showTarget(_ selector: String) -> Self { .init("showTarget", selector) }
    static func target(_ selector: String) -> Self { .init("target", selector) }
}

// MARK: TriggerModifiers

public extension HCONValue.Entry where Scope == HCONScope.TriggerModifiers {
    static var once: Self { .init("once") }
    static var changed: Self { .init("changed") }
    static func delay(_ duration: String) -> Self { .init("delay", duration) }
    static func throttle(_ duration: String) -> Self { .init("throttle", duration) }
    /// Listens on other elements, e.g. `.from("body")` or `.from("closest form")`.
    static func from(_ selector: String) -> Self { .init("from", selector) }
    /// Only fires if `event.target` matches the CSS selector.
    static func target(_ selector: String) -> Self { .init("target", selector) }
    static var prevent: Self { .init("prevent") }
    static var stop: Self { .init("stop") }
    static var consume: Self { .init("consume") }
    static var halt: Self { .init("halt") }
    static var capture: Self { .init("capture") }
    static var passive: Self { .init("passive") }
    /// `intersect` option.
    static func root(_ selector: String) -> Self { .init("root", selector) }
    /// `intersect` option.
    static func rootMargin(_ value: String) -> Self { .init("rootMargin", value) }
    /// `intersect` option.
    static func threshold(_ value: Double) -> Self { .init("threshold", value) }
}

// MARK: SwapOverride: StatusOverrides, BoostConfig

public extension HCONValue.Entry where Scope: HCONScope.SwapOverride {
    /// A swap style with optional modifiers, e.g. `.swap(.innerHTML, [.strip(true)])` renders `swap:'innerHTML strip:true'`.
    static func swap(
        _ style: HTMLAttributeValue.HTMX.SwapTarget,
        _ modifiers: HCONValue<HCONScope.SwapModifiers> = .init()
    ) -> Self {
        .init("swap", modifiers.isEmpty ? style.rawValue : "\(style.rawValue) \(modifiers.rawValue)")
    }

    static func target(_ selector: String) -> Self { .init("target", selector) }
    static func select(_ selector: String) -> Self { .init("select", selector) }
}

public extension HCONValue.Entry where Scope == HCONScope.StatusOverrides {
    static func push(_ value: Bool) -> Self { .init("push", value) }
    static func push(_ url: String) -> Self { .init("push", url) }
    static func replace(_ value: Bool) -> Self { .init("replace", value) }
    static func replace(_ url: String) -> Self { .init("replace", url) }
    static func transition(_ value: Bool) -> Self { .init("transition", value) }
}
