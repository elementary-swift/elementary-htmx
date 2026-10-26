import Elementary

public extension HTMLAttributeValue {
    /// A namespace for htmx 4 attribute value types.
    /// See the [htmx reference](https://four.htmx.org/reference) for more information.
    enum HTMX {}
}

public extension HTMLAttributeValue.HTMX {
    /// The attribute name modifiers for [attribute inheritance](https://four.htmx.org/docs#attribute-inheritance).
    struct InheritanceModifier: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// `hx-foo:inherited` - descendants inherit this value.
        public static var inherited: Self { .init(rawValue: ":inherited") }
        /// `hx-foo:append` - appends this value to the inherited value.
        public static var append: Self { .init(rawValue: ":append") }
        /// `hx-foo:inherited:append` - appends this value to the inherited value, and descendants inherit the result.
        public static var inheritedAppend: Self { .init(rawValue: ":inherited:append") }
    }
}

public extension HTMLAttributeValue.HTMX {
    struct Method: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var get: Self { .init(rawValue: "get") }
        public static var post: Self { .init(rawValue: "post") }
        public static var put: Self { .init(rawValue: "put") }
        public static var patch: Self { .init(rawValue: "patch") }
        public static var delete: Self { .init(rawValue: "delete") }
        public static var query: Self { .init(rawValue: "query") }
    }
}

public extension HTMLAttributeValue.HTMX {
    /// The swap style, e.g. `.outerHTML`. See the [hx-swap reference](https://four.htmx.org/reference/attributes/hx-swap#swap-methods).
    struct SwapStyle: RawRepresentable, ExpressibleByStringLiteral, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// A swap style from an extension, e.g. `.init("upsert")`.
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        public static var innerHTML: Self { "innerHTML" }
        public static var outerHTML: Self { "outerHTML" }
        public static var outerSync: Self { "outerSync" }
        public static var textContent: Self { "textContent" }
        public static var beforeBegin: Self { "beforebegin" }
        public static var before: Self { "before" }
        public static var afterBegin: Self { "afterbegin" }
        public static var prepend: Self { "prepend" }
        public static var beforeEnd: Self { "beforeend" }
        public static var append: Self { "append" }
        public static var afterEnd: Self { "afterend" }
        public static var after: Self { "after" }
        public static var innerMorph: Self { "innerMorph" }
        public static var outerMorph: Self { "outerMorph" }
        public static var delete: Self { "delete" }
        public static var none: Self { "none" }
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    struct ModifiedSwapTarget: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(_ swapStyle: SwapStyle) {
            rawValue = swapStyle.rawValue
        }

        public static var innerHTML: Self { .init(.innerHTML) }
        public static var outerHTML: Self { .init(.outerHTML) }
        public static var outerSync: Self { .init(.outerSync) }
        public static var textContent: Self { .init(.textContent) }
        public static var beforeBegin: Self { .init(.beforeBegin) }
        public static var before: Self { .init(.before) }
        public static var afterBegin: Self { .init(.afterBegin) }
        public static var prepend: Self { .init(.prepend) }
        public static var beforeEnd: Self { .init(.beforeEnd) }
        public static var append: Self { .init(.append) }
        public static var afterEnd: Self { .init(.afterEnd) }
        public static var after: Self { .init(.after) }
        public static var innerMorph: Self { .init(.innerMorph) }
        public static var outerMorph: Self { .init(.outerMorph) }
        public static var delete: Self { .init(.delete) }
        public static var none: Self { .init(.none) }
        public static var `default`: Self { .init("") }
    }
}

@available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
public extension HTMLAttributeValue.HTMX.ModifiedSwapTarget {
    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func transition(_ value: Bool) -> Self {
        appending(modifier: "transition", value: value.stringValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func swap(_ duration: String) -> Self {
        appending(modifier: "swap", value: duration)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func settle(_ duration: String) -> Self {
        appending(modifier: "settle", value: duration)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func ignoreTitle(_ value: Bool) -> Self {
        appending(modifier: "ignoreTitle", value: value.stringValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func strip(_ value: Bool) -> Self {
        appending(modifier: "strip", value: value.stringValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func focusScroll(_ value: Bool) -> Self {
        appending(modifier: "focusScroll", value: value.stringValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func swapEmpty(_ value: Bool) -> Self {
        appending(modifier: "swapEmpty", value: value.stringValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func scroll(_ value: HTMLAttributeValue.HTMX.ScrollPosition) -> Self {
        appending(modifier: "scroll", value: value.rawValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func scrollTarget(_ selector: String) -> Self {
        appending(modifier: "scrollTarget", value: selector)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func show(_ value: HTMLAttributeValue.HTMX.ScrollPosition) -> Self {
        appending(modifier: "show", value: value.rawValue)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func showTarget(_ selector: String) -> Self {
        appending(modifier: "showTarget", value: selector)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.swap(.outerHTML, [.transition(true)])")
    consuming func target(_ selector: String) -> Self {
        appending(modifier: "target", value: selector)
    }

    internal consuming func appending(modifier: String, value: String) -> Self {
        if !rawValue.isEmpty {
            rawValue += " "
        }
        rawValue += modifier
        rawValue += ":"
        rawValue += value

        return self
    }
}

public extension HTMLAttributeValue.HTMX {
    /// The position for the `scroll` and `show` swap modifiers.
    struct ScrollPosition: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var top: Self { .init(rawValue: "top") }
        public static var bottom: Self { .init(rawValue: "bottom") }
        /// Only valid for `show`, e.g. to turn off `show:top` on boosted forms. `scroll` accepts `top` and `bottom`.
        public static var none: Self { .init(rawValue: "none") }
    }
}

public extension HTMLAttributeValue.HTMX {
    /// Events that htmx fires itself, for use in `hx-trigger`.
    /// See the [hx-trigger reference](https://four.htmx.org/reference/attributes/hx-trigger#synthetic-events).
    struct SyntheticEvent: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var load: Self { .init(rawValue: "load") }
        public static var revealed: Self { .init(rawValue: "revealed") }
        public static var intersect: Self { .init(rawValue: "intersect") }
    }

    /// The event part of an `hx-trigger` value: an event with an optional filter, or a polling interval.
    struct Trigger: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static func event(_ event: HTMLAttributeValue.MouseEvent, filter: String? = nil) -> Self {
            .event(event.rawValue, filter: filter)
        }
        public static func event(_ event: HTMLAttributeValue.KeyboardEvent, filter: String? = nil) -> Self {
            .event(event.rawValue, filter: filter)
        }
        public static func event(_ event: HTMLAttributeValue.FormEvent, filter: String? = nil) -> Self {
            .event(event.rawValue, filter: filter)
        }
        public static func event(_ event: HTMLAttributeValue.HTMX.SyntheticEvent, filter: String? = nil) -> Self {
            .event(event.rawValue, filter: filter)
        }
        /// Any DOM or custom event, e.g. `.event("productsUpdated")`.
        /// The filter is a JavaScript expression, e.g. `.event(.keyup, filter: "key=='Enter'")` renders `keyup[key=='Enter']`.
        public static func event(_ name: String, filter: String? = nil) -> Self {
            if let filter {
                .init(rawValue: "\(name)[\(filter)]")
            } else {
                .init(rawValue: name)
            }
        }

        /// Polls on an interval. The filter is a JavaScript expression, e.g. `.every("1s", filter: "isVisible()")`
        /// renders `every 1s [isVisible()]`.
        public static func every(_ interval: String, filter: String? = nil) -> Self {
            if let filter {
                .init(rawValue: "every \(interval) [\(filter)]")
            } else {
                .init(rawValue: "every \(interval)")
            }
        }
    }
}

public extension HTMLAttributeValue.HTMX.Trigger {
    /// Adds a filter expression, e.g. `keyup[key=='Enter']`, or `every 1s [someConditional]` for polling.
    @available(*, deprecated, message: "Use the filter parameter, e.g. .event(.keyup, filter: \"key=='Enter'\")")
    consuming func filter(_ expression: String) -> Self {
        let filter = "[\(expression)]"
        if rawValue.hasPrefix("every ") {
            rawValue += " \(filter)"
        } else if let space = rawValue.firstIndex(of: " ") {
            rawValue.insert(contentsOf: filter, at: space)
        } else {
            rawValue += filter
        }
        return self
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func once() -> Self {
        appending(modifier: "once")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func changed() -> Self {
        appending(modifier: "changed")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func delay(_ value: String) -> Self {
        appending(modifier: "delay", value: value)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func throttle(_ value: String) -> Self {
        appending(modifier: "throttle", value: value)
    }

    /// Selectors with spaces or commas must be quoted, e.g. `.from("'closest form'")`.
    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func from(_ selector: String) -> Self {
        appending(modifier: "from", value: selector)
    }

    /// Selectors with spaces or commas must be quoted, e.g. `.target("'.a, .b'")`.
    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func target(_ selector: String) -> Self {
        appending(modifier: "target", value: selector)
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func prevent() -> Self {
        appending(modifier: "prevent")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func stop() -> Self {
        appending(modifier: "stop")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func consume() -> Self {
        appending(modifier: "consume")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func halt() -> Self {
        appending(modifier: "halt")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func capture() -> Self {
        appending(modifier: "capture")
    }

    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func passive() -> Self {
        appending(modifier: "passive")
    }

    /// `intersect` option.
    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func root(_ selector: String) -> Self {
        appending(modifier: "root", value: selector)
    }

    /// `intersect` option.
    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func rootMargin(_ value: String) -> Self {
        appending(modifier: "rootMargin", value: value)
    }

    /// `intersect` option.
    @available(*, deprecated, message: "Use modifier entries: .hx.trigger(.event(.click), [.once])")
    consuming func threshold(_ value: Double) -> Self {
        appending(modifier: "threshold", value: "\(value)")
    }

    internal consuming func appending(modifier: String, value: String? = nil) -> Self {
        rawValue += " "
        rawValue += modifier
        if let value {
            rawValue += ":"
            rawValue += value
        }
        return self
    }
}

public extension HTMLAttributeValue.HTMX {
    struct SyncStrategy: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var drop: Self { .init(rawValue: "drop") }
        public static var abort: Self { .init(rawValue: "abort") }
        public static var replace: Self { .init(rawValue: "replace") }
        public static var queue: Self { .init(rawValue: "queue") }
        public static var queueFirst: Self { .init(rawValue: "queue first") }
        public static var queueLast: Self { .init(rawValue: "queue last") }
        public static var queueAll: Self { .init(rawValue: "queue all") }
    }
}

public extension HTMLAttributeValue.HTMX {
    @available(*, deprecated, renamed: "SwapStyle")
    typealias SwapTarget = SwapStyle

    @available(*, deprecated, renamed: "ScrollPosition")
    typealias ScrollModifier = ScrollPosition

    @available(*, deprecated, renamed: "SyntheticEvent")
    typealias TriggerEvent = SyntheticEvent

    @available(*, deprecated, renamed: "Trigger")
    typealias EventTrigger = Trigger

    @available(*, deprecated, renamed: "Trigger")
    typealias PollingTrigger = Trigger
}

extension Bool {
    var stringValue: String { self ? "true" : "false" }
}
