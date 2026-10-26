import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for htmx 4 attributes.
    /// See the [htmx reference](https://four.htmx.org/reference) for more information.
    ///
    /// Attributes that htmx resolves through inheritance have an overload that takes a leading
    /// ``HTMLAttributeValue/HTMX/InheritanceModifier``, e.g. `.hx.confirm(.inherited, "Are you sure?")`
    /// renders `hx-confirm:inherited="Are you sure?"`.
    public enum hx {}
}

typealias InheritanceModifier = HTMLAttributeValue.HTMX.InheritanceModifier

extension HTMLAttribute.hx {
    static func attribute(
        _ name: String,
        _ modifier: InheritanceModifier?,
        _ value: String?,
        mergedBy action: HTMLAttributeMergeAction = .replacing
    ) -> HTMLAttribute<Tag> {
        .init(name: name + (modifier?.rawValue ?? ""), value: value, mergedBy: action)
    }
}

// MARK: requests

extension HTMLAttribute.hx {
    public static func get(_ url: String) -> HTMLAttribute<Tag> {
        get(nil, url)
    }

    public static func get(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-get", modifier, url)
    }

    public static func post(_ url: String) -> HTMLAttribute<Tag> {
        post(nil, url)
    }

    public static func post(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-post", modifier, url)
    }

    public static func put(_ url: String) -> HTMLAttribute<Tag> {
        put(nil, url)
    }

    public static func put(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-put", modifier, url)
    }

    public static func patch(_ url: String) -> HTMLAttribute<Tag> {
        patch(nil, url)
    }

    public static func patch(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-patch", modifier, url)
    }

    public static func delete(_ url: String) -> HTMLAttribute<Tag> {
        delete(nil, url)
    }

    public static func delete(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-delete", modifier, url)
    }

    public static func query(_ url: String) -> HTMLAttribute<Tag> {
        query(nil, url)
    }

    public static func query(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-query", modifier, url)
    }

    public static func action(_ url: String) -> HTMLAttribute<Tag> {
        action(nil, url)
    }

    public static func action(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-action", modifier, url)
    }

    public static func method(_ method: HTMLAttributeValue.HTMX.Method) -> HTMLAttribute<Tag> {
        Self.method(nil, method)
    }

    public static func method(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ method: HTMLAttributeValue.HTMX.Method
    ) -> HTMLAttribute<Tag> {
        attribute("hx-method", modifier, method.rawValue)
    }
}

// MARK: request control

extension HTMLAttribute.hx {
    public static func trigger(_ value: HTMLAttributeValue.HTMX.EventTrigger) -> HTMLAttribute<Tag> {
        trigger(nil, value)
    }

    public static func trigger(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ value: HTMLAttributeValue.HTMX.EventTrigger
    ) -> HTMLAttribute<Tag> {
        attribute("hx-trigger", modifier, value.rawValue, mergedBy: .appending(separatedBy: ", "))
    }

    /// A trigger with modifiers, e.g. `.hx.trigger(.event(.input), [.changed, .delay("500ms")])`.
    public static func trigger(
        _ value: HTMLAttributeValue.HTMX.EventTrigger,
        _ modifiers: HCONValue<HCONScope.TriggerModifiers>
    ) -> HTMLAttribute<Tag> {
        trigger(nil, value, modifiers)
    }

    public static func trigger(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ value: HTMLAttributeValue.HTMX.EventTrigger,
        _ modifiers: HCONValue<HCONScope.TriggerModifiers>
    ) -> HTMLAttribute<Tag> {
        attribute(
            "hx-trigger",
            modifier,
            modifiers.isEmpty ? value.rawValue : "\(value.rawValue) \(modifiers.rawValue)",
            mergedBy: .appending(separatedBy: ", ")
        )
    }

    public static func trigger(_ value: HTMLAttributeValue.HTMX.PollingTrigger) -> HTMLAttribute<Tag> {
        trigger(nil, value)
    }

    public static func trigger(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ value: HTMLAttributeValue.HTMX.PollingTrigger
    ) -> HTMLAttribute<Tag> {
        attribute("hx-trigger", modifier, value.rawValue, mergedBy: .appending(separatedBy: ", "))
    }

    public static func swap(_ style: HTMLAttributeValue.HTMX.SwapTarget) -> HTMLAttribute<Tag> {
        swap(nil, style)
    }

    public static func swap(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ style: HTMLAttributeValue.HTMX.SwapTarget
    ) -> HTMLAttribute<Tag> {
        attribute("hx-swap", modifier, style.rawValue)
    }

    /// A swap style with modifiers, e.g. `.hx.swap(.beforeEnd, [.scroll(.bottom)])`.
    public static func swap(
        _ style: HTMLAttributeValue.HTMX.SwapTarget,
        _ modifiers: HCONValue<HCONScope.SwapModifiers>
    ) -> HTMLAttribute<Tag> {
        swap(nil, style, modifiers)
    }

    public static func swap(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ style: HTMLAttributeValue.HTMX.SwapTarget,
        _ modifiers: HCONValue<HCONScope.SwapModifiers>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-swap", modifier, modifiers.isEmpty ? style.rawValue : "\(style.rawValue) \(modifiers.rawValue)")
    }

    /// Modifiers for the default swap style, e.g. `.hx.swap([.transition(true)])`.
    public static func swap(_ modifiers: HCONValue<HCONScope.SwapModifiers>) -> HTMLAttribute<Tag> {
        swap(nil, modifiers)
    }

    public static func swap(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ modifiers: HCONValue<HCONScope.SwapModifiers>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-swap", modifier, modifiers.rawValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    @_disfavoredOverload
    public static func swap(_ value: HTMLAttributeValue.HTMX.ModifiedSwapTarget) -> HTMLAttribute<Tag> {
        swap(nil, value)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.inherited, .outerHTML, [.transition(true)])")
    @_disfavoredOverload
    public static func swap(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ value: HTMLAttributeValue.HTMX.ModifiedSwapTarget
    ) -> HTMLAttribute<Tag> {
        attribute("hx-swap", modifier, value.rawValue)
    }

    public static func target(_ selector: String) -> HTMLAttribute<Tag> {
        target(nil, selector)
    }

    public static func target(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ selector: String) -> HTMLAttribute<Tag> {
        attribute("hx-target", modifier, selector)
    }

    public static func select(_ selector: String) -> HTMLAttribute<Tag> {
        select(nil, selector)
    }

    public static func select(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ selector: String) -> HTMLAttribute<Tag> {
        attribute("hx-select", modifier, selector)
    }

    public static func selectOOB(
        _ selector: String,
        _ swap: HTMLAttributeValue.HTMX.SwapTarget? = nil
    ) -> HTMLAttribute<Tag> {
        selectOOB(nil, selector, swap)
    }

    public static func selectOOB(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ selector: String,
        _ swap: HTMLAttributeValue.HTMX.SwapTarget? = nil
    ) -> HTMLAttribute<Tag> {
        if let swap {
            attribute("hx-select-oob", modifier, "\(selector):\(swap.rawValue)", mergedBy: .appending(separatedBy: ","))
        } else {
            attribute("hx-select-oob", modifier, selector, mergedBy: .appending(separatedBy: ","))
        }
    }

    public static func swapOOB(_ value: Bool) -> HTMLAttribute<Tag> {
        .init(name: "hx-swap-oob", value: value.stringValue)
    }

    public static func swapOOB(
        _ swap: HTMLAttributeValue.HTMX.SwapTarget,
        _ selector: String? = nil
    ) -> HTMLAttribute<Tag> {
        if let selector {
            .init(name: "hx-swap-oob", value: "\(swap.rawValue):\(selector)")
        } else {
            .init(name: "hx-swap-oob", value: swap.rawValue)
        }
    }

    /// An out-of-band swap with modifiers, e.g. `.hx.swapOOB(.beforeEnd, [.target("#table tbody")])`.
    public static func swapOOB(
        _ style: HTMLAttributeValue.HTMX.SwapTarget,
        _ modifiers: HCONValue<HCONScope.SwapModifiers>
    ) -> HTMLAttribute<Tag> {
        .init(name: "hx-swap-oob", value: modifiers.isEmpty ? style.rawValue : "\(style.rawValue) \(modifiers.rawValue)")
    }

    public static func confirm(_ value: String) -> HTMLAttribute<Tag> {
        confirm(nil, value)
    }

    public static func confirm(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: String) -> HTMLAttribute<Tag> {
        attribute("hx-confirm", modifier, value)
    }
}

// MARK: scripting

extension HTMLAttribute.hx {
    /// Renders `hx-on:<event>`. Use `":<event>"` as shorthand for htmx events, e.g. `":before:request"` renders `hx-on::before:request`.
    public static func on(_ event: String, _ script: String) -> HTMLAttribute<Tag> {
        .init(name: "hx-on:\(event)", value: script)
    }

    public static func on(_ event: HTMLAttributeValue.MouseEvent, _ script: String) -> HTMLAttribute<Tag> {
        on(event.rawValue, script)
    }

    public static func on(_ event: HTMLAttributeValue.KeyboardEvent, _ script: String) -> HTMLAttribute<Tag> {
        on(event.rawValue, script)
    }

    public static func on(_ event: HTMLAttributeValue.FormEvent, _ script: String) -> HTMLAttribute<Tag> {
        on(event.rawValue, script)
    }

    /// Renders the extended form `hx-on="<event> -> <js>; ..."`.
    public static func on(_ handlers: String) -> HTMLAttribute<Tag> {
        .init(name: "hx-on", value: handlers)
    }
}

// MARK: data

extension HTMLAttribute.hx {
    public static func vals(_ value: String) -> HTMLAttribute<Tag> {
        vals(nil, value)
    }

    public static func vals(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: String) -> HTMLAttribute<Tag> {
        attribute("hx-vals", modifier, value)
    }

    /// Values as HCON entries, e.g. `.hx.vals([.init("draft", true)])` renders `hx-vals="draft:true"`.
    public static func vals(_ values: HCONValue<HCONScope.Values>) -> HTMLAttribute<Tag> {
        vals(nil, values)
    }

    public static func vals(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ values: HCONValue<HCONScope.Values>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-vals", modifier, values.rawValue)
    }

    public static func include(_ selector: String) -> HTMLAttribute<Tag> {
        include(nil, selector)
    }

    public static func include(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ selector: String) -> HTMLAttribute<Tag> {
        attribute("hx-include", modifier, selector)
    }

    public static func headers(_ value: String) -> HTMLAttribute<Tag> {
        headers(nil, value)
    }

    public static func headers(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: String) -> HTMLAttribute<Tag> {
        attribute("hx-headers", modifier, value)
    }

    /// Headers as HCON entries, e.g. `.hx.headers([.init("X-Widget-Id", "42")])`.
    public static func headers(_ values: HCONValue<HCONScope.Values>) -> HTMLAttribute<Tag> {
        headers(nil, values)
    }

    public static func headers(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ values: HCONValue<HCONScope.Values>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-headers", modifier, values.rawValue)
    }

    public static func encoding(_ value: String) -> HTMLAttribute<Tag> {
        encoding(nil, value)
    }

    public static func encoding(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: String) -> HTMLAttribute<Tag> {
        attribute("hx-encoding", modifier, value)
    }
}

// MARK: history

extension HTMLAttribute.hx {
    public static func pushURL(_ url: String) -> HTMLAttribute<Tag> {
        pushURL(nil, url)
    }

    public static func pushURL(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-push-url", modifier, url)
    }

    public static func pushURL(_ value: Bool) -> HTMLAttribute<Tag> {
        pushURL(nil, value)
    }

    public static func pushURL(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: Bool) -> HTMLAttribute<Tag> {
        attribute("hx-push-url", modifier, value.stringValue)
    }

    public static func replaceURL(_ url: String) -> HTMLAttribute<Tag> {
        replaceURL(nil, url)
    }

    public static func replaceURL(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ url: String) -> HTMLAttribute<Tag> {
        attribute("hx-replace-url", modifier, url)
    }

    public static func replaceURL(_ value: Bool) -> HTMLAttribute<Tag> {
        replaceURL(nil, value)
    }

    public static func replaceURL(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: Bool) -> HTMLAttribute<Tag> {
        attribute("hx-replace-url", modifier, value.stringValue)
    }

    public static var historyElt: HTMLAttribute<Tag> {
        .init(name: "hx-history-elt", value: nil)
    }
}

// MARK: enhancements

extension HTMLAttribute.hx {
    public static func boost(_ value: Bool) -> HTMLAttribute<Tag> {
        boost(nil, value)
    }

    public static func boost(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: Bool) -> HTMLAttribute<Tag> {
        attribute("hx-boost", modifier, value.stringValue)
    }

    /// Boost with config, e.g. `.hx.boost(.inherited, [.swap(.outerSync), .select("#main"), .target("#main")])`.
    public static func boost(_ config: HCONValue<HCONScope.BoostConfig>) -> HTMLAttribute<Tag> {
        boost(nil, config)
    }

    public static func boost(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ config: HCONValue<HCONScope.BoostConfig>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-boost", modifier, config.rawValue)
    }
}

// MARK: advanced

extension HTMLAttribute.hx {
    public static func indicator(_ selector: String) -> HTMLAttribute<Tag> {
        indicator(nil, selector)
    }

    public static func indicator(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ selector: String) -> HTMLAttribute<Tag> {
        attribute("hx-indicator", modifier, selector)
    }

    /// Renders `hx-status:<code>`, e.g. `.hx.status("422", [.target("#errors")])`. Codes may use wildcards like `"5xx"`.
    public static func status(
        _ code: String,
        _ overrides: HCONValue<HCONScope.StatusOverrides>
    ) -> HTMLAttribute<Tag> {
        status(nil, code, overrides)
    }

    public static func status(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ code: String,
        _ overrides: HCONValue<HCONScope.StatusOverrides>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-status:\(code)", modifier, overrides.rawValue)
    }

    public static func sync(
        _ selector: String,
        _ strategy: HTMLAttributeValue.HTMX.SyncStrategy? = nil
    ) -> HTMLAttribute<Tag> {
        sync(nil, selector, strategy)
    }

    public static func sync(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ selector: String,
        _ strategy: HTMLAttributeValue.HTMX.SyncStrategy? = nil
    ) -> HTMLAttribute<Tag> {
        if let strategy {
            attribute("hx-sync", modifier, "\(selector):\(strategy.rawValue)")
        } else {
            attribute("hx-sync", modifier, selector)
        }
    }

    public static func sync(_ strategy: HTMLAttributeValue.HTMX.SyncStrategy) -> HTMLAttribute<Tag> {
        sync(nil, strategy)
    }

    public static func sync(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ strategy: HTMLAttributeValue.HTMX.SyncStrategy
    ) -> HTMLAttribute<Tag> {
        attribute("hx-sync", modifier, strategy.rawValue)
    }

    public static func validate(_ value: Bool) -> HTMLAttribute<Tag> {
        validate(nil, value)
    }

    public static func validate(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ value: Bool) -> HTMLAttribute<Tag> {
        attribute("hx-validate", modifier, value.stringValue)
    }

    /// Adds `disabled` to the selected elements while a request is in flight, e.g. `.hx.disable("this")`.
    public static func disable(_ selector: String) -> HTMLAttribute<Tag> {
        disable(nil, selector)
    }

    public static func disable(_ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?, _ selector: String) -> HTMLAttribute<Tag> {
        attribute("hx-disable", modifier, selector)
    }

    /// Disables htmx processing for this element and all its children.
    public static var ignore: HTMLAttribute<Tag> {
        .init(name: "hx-ignore", value: nil)
    }

    public static var preserve: HTMLAttribute<Tag> {
        .init(name: "hx-preserve", value: nil)
    }

    public static var morphSkip: HTMLAttribute<Tag> {
        .init(name: "hx-morph-skip", value: nil)
    }

    public static var morphSkipChildren: HTMLAttribute<Tag> {
        .init(name: "hx-morph-skip-children", value: nil)
    }

    /// Per-request config, e.g. `.hx.config([.timeout("5s"), .cache("no-cache")])` renders `hx-config="timeout:5s cache:no-cache"`.
    public static func config(_ value: HCONValue<HCONScope.RequestConfig>) -> HTMLAttribute<Tag> {
        config(nil, value)
    }

    public static func config(
        _ modifier: HTMLAttributeValue.HTMX.InheritanceModifier?,
        _ value: HCONValue<HCONScope.RequestConfig>
    ) -> HTMLAttribute<Tag> {
        attribute("hx-config", modifier, value.rawValue)
    }
}
