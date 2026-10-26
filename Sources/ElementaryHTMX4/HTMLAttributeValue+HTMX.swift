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
    struct SwapTarget: RawRepresentable, ExpressibleByStringLiteral, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
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

    struct ModifiedSwapTarget: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(_ swapTarget: SwapTarget) {
            rawValue = swapTarget.rawValue
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

public extension HTMLAttributeValue.HTMX.ModifiedSwapTarget {
    consuming func transition(_ value: Bool) -> Self {
        appending(modifier: "transition", value: value.stringValue)
    }

    consuming func swap(_ duration: String) -> Self {
        appending(modifier: "swap", value: duration)
    }

    consuming func settle(_ duration: String) -> Self {
        appending(modifier: "settle", value: duration)
    }

    consuming func ignoreTitle(_ value: Bool) -> Self {
        appending(modifier: "ignoreTitle", value: value.stringValue)
    }

    consuming func strip(_ value: Bool) -> Self {
        appending(modifier: "strip", value: value.stringValue)
    }

    consuming func focusScroll(_ value: Bool) -> Self {
        appending(modifier: "focusScroll", value: value.stringValue)
    }

    consuming func swapEmpty(_ value: Bool) -> Self {
        appending(modifier: "swapEmpty", value: value.stringValue)
    }

    consuming func scroll(_ value: HTMLAttributeValue.HTMX.ScrollModifier) -> Self {
        appending(modifier: "scroll", value: value.rawValue)
    }

    consuming func scrollTarget(_ selector: String) -> Self {
        appending(modifier: "scrollTarget", value: selector)
    }

    consuming func show(_ value: HTMLAttributeValue.HTMX.ScrollModifier) -> Self {
        appending(modifier: "show", value: value.rawValue)
    }

    consuming func showTarget(_ selector: String) -> Self {
        appending(modifier: "showTarget", value: selector)
    }

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
    struct ScrollModifier: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var top: Self { .init(rawValue: "top") }
        public static var bottom: Self { .init(rawValue: "bottom") }
        /// Only valid for `show`.
        public static var none: Self { .init(rawValue: "none") }
    }
}

public extension HTMLAttributeValue.HTMX {
    struct TriggerEvent: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var load: Self { .init(rawValue: "load") }
        public static var revealed: Self { .init(rawValue: "revealed") }
        public static var intersect: Self { .init(rawValue: "intersect") }
    }

    struct EventTrigger: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static func event(_ event: HTMLAttributeValue.MouseEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        public static func event(_ event: HTMLAttributeValue.KeyboardEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        public static func event(_ event: HTMLAttributeValue.FormEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        public static func event(_ event: HTMLAttributeValue.HTMX.TriggerEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        /// Any DOM or custom event, e.g. `.event("productsUpdated").from("body")`.
        public static func event(_ name: String) -> Self { .init(rawValue: name) }
    }

    struct PollingTrigger: RawRepresentable, Sendable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static func every(_ interval: String) -> Self { .init(rawValue: "every \(interval)") }
    }
}

public extension HTMLAttributeValue.HTMX.EventTrigger {
    /// Adds a filter expression after the event name, e.g. `keyup[key=='Enter']`.
    consuming func filter(_ expression: String) -> Self {
        let filter = "[\(expression)]"
        if let space = rawValue.firstIndex(of: " ") {
            rawValue.insert(contentsOf: filter, at: space)
        } else {
            rawValue += filter
        }
        return self
    }

    consuming func once() -> Self {
        appending(modifier: "once")
    }

    consuming func changed() -> Self {
        appending(modifier: "changed")
    }

    consuming func delay(_ value: String) -> Self {
        appending(modifier: "delay", value: value)
    }

    consuming func throttle(_ value: String) -> Self {
        appending(modifier: "throttle", value: value)
    }

    /// Selectors with spaces or commas must be quoted, e.g. `.from("'closest form'")`.
    consuming func from(_ selector: String) -> Self {
        appending(modifier: "from", value: selector)
    }

    /// Selectors with spaces or commas must be quoted, e.g. `.target("'.a, .b'")`.
    consuming func target(_ selector: String) -> Self {
        appending(modifier: "target", value: selector)
    }

    consuming func prevent() -> Self {
        appending(modifier: "prevent")
    }

    consuming func stop() -> Self {
        appending(modifier: "stop")
    }

    consuming func consume() -> Self {
        appending(modifier: "consume")
    }

    consuming func halt() -> Self {
        appending(modifier: "halt")
    }

    consuming func capture() -> Self {
        appending(modifier: "capture")
    }

    consuming func passive() -> Self {
        appending(modifier: "passive")
    }

    /// `intersect` option.
    consuming func root(_ selector: String) -> Self {
        appending(modifier: "root", value: selector)
    }

    /// `intersect` option.
    consuming func rootMargin(_ value: String) -> Self {
        appending(modifier: "rootMargin", value: value)
    }

    /// `intersect` option.
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

public extension HTMLAttributeValue.HTMX.PollingTrigger {
    /// Adds a filter expression after the interval, e.g. `every 1s [someConditional]`.
    consuming func filter(_ expression: String) -> Self {
        rawValue += " [\(expression)]"
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

extension Bool {
    var stringValue: String { self ? "true" : "false" }
}
