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
    @inlinable
    static func transitions(_ value: Bool) -> Self { .init("transitions", value) }
    @inlinable
    static func history(_ value: Bool) -> Self { .init("history", value) }
    /// `"reload"` does a full page reload on history navigation.
    @inlinable
    static func history(_ value: String) -> Self { .init("history", value) }
    @inlinable
    static func mode(_ value: String) -> Self { .init("mode", value) }
    @inlinable
    static func defaultSwap(_ value: HTMLAttributeValue.HTMX.SwapStyle) -> Self { .init("defaultSwap", value.rawValue) }
    @inlinable
    static func allowEmptySwapAfterOOB(_ value: Bool) -> Self { .init("allowEmptySwapAfterOOB", value) }
    @inlinable
    static func includeIndicatorCSS(_ value: Bool) -> Self { .init("includeIndicatorCSS", value) }
    /// In milliseconds.
    @inlinable
    static func defaultTimeout(_ value: Int) -> Self { .init("defaultTimeout", value) }
    /// A comma-separated list of extension names, e.g. `"sse,ws"`.
    @inlinable
    static func extensions(_ value: String) -> Self { .init("extensions", value) }
    @inlinable
    static func morphIgnore(_ value: [String]) -> Self { .init("morphIgnore", value) }
    /// Status codes and patterns, e.g. `["204", "304", "4xx", "5xx"]`.
    @inlinable
    static func noSwap(_ value: [String]) -> Self { .init("noSwap", value) }
    @inlinable
    static func implicitInheritance(_ value: Bool) -> Self { .init("implicitInheritance", value) }
    @inlinable
    static func inlineScriptNonce(_ value: String) -> Self { .init("inlineScriptNonce", value) }
}

// MARK: RequestConfig

public extension HCONValue.Entry where Scope == HCONScope.RequestConfig {
    /// A time string such as `"5s"`, or milliseconds.
    @inlinable
    static func timeout(_ value: String) -> Self { .init("timeout", value) }
    /// `"omit"`, `"same-origin"` or `"include"`.
    @inlinable
    static func credentials(_ value: String) -> Self { .init("credentials", value) }
    /// A fetch cache mode, e.g. `"no-cache"`.
    @inlinable
    static func cache(_ value: String) -> Self { .init("cache", value) }
    /// `"follow"`, `"error"` or `"manual"`.
    @inlinable
    static func redirect(_ value: String) -> Self { .init("redirect", value) }
    /// A referrer URL or `"no-referrer"`.
    @inlinable
    static func referrer(_ value: String) -> Self { .init("referrer", value) }
    @inlinable
    static func integrity(_ value: String) -> Self { .init("integrity", value) }
    @inlinable
    static func validate(_ value: Bool) -> Self { .init("validate", value) }
}

// MARK: SwapModifiers

public extension HCONValue.Entry where Scope == HCONScope.SwapModifiers {
    @inlinable
    static func transition(_ value: Bool) -> Self { .init("transition", value) }
    /// A delay before the swap, e.g. `"1s"`.
    @inlinable
    static func swap(_ duration: String) -> Self { .init("swap", duration) }
    /// A delay between swap and settle, e.g. `"10ms"`.
    @inlinable
    static func settle(_ duration: String) -> Self { .init("settle", duration) }
    @inlinable
    static func ignoreTitle(_ value: Bool) -> Self { .init("ignoreTitle", value) }
    @inlinable
    static func strip(_ value: Bool) -> Self { .init("strip", value) }
    @inlinable
    static func focusScroll(_ value: Bool) -> Self { .init("focusScroll", value) }
    @inlinable
    static func swapEmpty(_ value: Bool) -> Self { .init("swapEmpty", value) }
    /// Scrolls the target to `.top` or `.bottom`.
    @inlinable
    static func scroll(_ value: HTMLAttributeValue.HTMX.ScrollPosition) -> Self { .init("scroll", value.rawValue) }
    @inlinable
    static func scrollTarget(_ selector: String) -> Self { .init("scrollTarget", selector) }
    /// Scrolls the target's `.top` or `.bottom` into view, or `.none` to turn it off.
    @inlinable
    static func show(_ value: HTMLAttributeValue.HTMX.ScrollPosition) -> Self { .init("show", value.rawValue) }
    @inlinable
    static func showTarget(_ selector: String) -> Self { .init("showTarget", selector) }
    @inlinable
    static func target(_ selector: String) -> Self { .init("target", selector) }
}

// MARK: TriggerModifiers

public extension HCONValue.Entry where Scope == HCONScope.TriggerModifiers {
    @inlinable
    static var once: Self { .init("once") }
    @inlinable
    static var changed: Self { .init("changed") }
    @inlinable
    static func delay(_ duration: String) -> Self { .init("delay", duration) }
    @inlinable
    static func throttle(_ duration: String) -> Self { .init("throttle", duration) }
    /// Listens on other elements, e.g. `.from("body")` or `.from("closest form")`.
    @inlinable
    static func from(_ selector: String) -> Self { .init("from", selector) }
    /// Only fires if `event.target` matches the CSS selector.
    @inlinable
    static func target(_ selector: String) -> Self { .init("target", selector) }
    @inlinable
    static var prevent: Self { .init("prevent") }
    @inlinable
    static var stop: Self { .init("stop") }
    @inlinable
    static var consume: Self { .init("consume") }
    @inlinable
    static var halt: Self { .init("halt") }
    @inlinable
    static var capture: Self { .init("capture") }
    @inlinable
    static var passive: Self { .init("passive") }
    /// `intersect` option.
    @inlinable
    static func root(_ selector: String) -> Self { .init("root", selector) }
    /// `intersect` option.
    @inlinable
    static func rootMargin(_ value: String) -> Self { .init("rootMargin", value) }
    /// `intersect` option.
    @inlinable
    static func threshold(_ value: Double) -> Self { .init("threshold", value) }
}

// MARK: SwapOverride: StatusOverrides, BoostConfig

public extension HCONValue.Entry where Scope: HCONScope.SwapOverride {
    /// A swap style with optional modifiers, e.g. `.swap(.innerHTML, [.strip(true)])` renders `swap:'innerHTML strip:true'`.
    @inlinable
    static func swap(
        _ style: HTMLAttributeValue.HTMX.SwapStyle,
        _ modifiers: HCONValue<HCONScope.SwapModifiers> = .init()
    ) -> Self {
        .init("swap", modifiers.isEmpty ? style.rawValue : "\(style.rawValue) \(modifiers.rawValue)")
    }

    @inlinable
    static func target(_ selector: String) -> Self { .init("target", selector) }
    @inlinable
    static func select(_ selector: String) -> Self { .init("select", selector) }
}

public extension HCONValue.Entry where Scope == HCONScope.StatusOverrides {
    @inlinable
    static func push(_ value: Bool) -> Self { .init("push", value) }
    @inlinable
    static func push(_ url: String) -> Self { .init("push", url) }
    @inlinable
    static func replace(_ value: Bool) -> Self { .init("replace", value) }
    @inlinable
    static func replace(_ url: String) -> Self { .init("replace", url) }
    @inlinable
    static func transition(_ value: Bool) -> Self { .init("transition", value) }
}
