import Elementary

/// `key:value` entries rendered as [HCON](https://four.htmx.org/docs/hcon-guide), htmx's config notation.
///
/// `Scope` is a phantom type from ``HCONScope`` that selects which typed entries are available,
/// e.g. ``HCONScope/GlobalConfig`` for `meta(htmxConfig:)` and ``HCONScope/SwapModifiers`` for `.hx.swap(_:_:)`.
/// Any key can be set with `.init(key, value)`. Dotted keys set nested options, e.g. `.init("sse.reconnectDelay", "1s")`.
///
/// The entries are rendered once, when the value is created.
public struct HCONValue<Scope>: Sendable, ExpressibleByArrayLiteral {
    public let rawValue: String

    /// No entries. Used as the default for optional modifiers.
    public init() {
        rawValue = ""
    }

    public init(_ entries: [Entry]) {
        var result = ""
        for entry in entries {
            if !result.isEmpty {
                result.append(" ")
            }
            result.append(entry.key)
            if let value = entry.value {
                result.append(":")
                result.append(value)
            }
        }
        rawValue = result
    }

    public init(arrayLiteral entries: Entry...) {
        self.init(entries)
    }

    public var isEmpty: Bool { rawValue.isEmpty }

    /// A `key:value` pair, or a bare `key` flag. The value is encoded for HCON when the entry is created.
    ///
    /// Keys are rendered as-is, so dotted keys like `sse.reconnectDelay` set nested options.
    public struct Entry: Sendable {
        public var key: String
        /// The HCON-encoded value, including quotes if needed. `nil` for a bare flag.
        public private(set) var value: String?

        init(key: String, encodedValue: String?) {
            self.key = key
            self.value = encodedValue
        }
    }
}

public extension HCONValue.Entry {
    /// A bare flag, e.g. `once`. HCON reads a key without a value as `true`.
    init(_ key: String) {
        self.init(key: key, encodedValue: nil)
    }

    /// A string value. HCON reads a bare value up to whitespace or a comma, so values that contain
    /// whitespace or commas, are empty, or start with a quote or `<` are quoted.
    init(_ key: String, _ value: String) {
        let needsQuotes =
            value.isEmpty
            || value.first == "\"" || value.first == "'" || value.first == "<"
            || value.contains(where: { $0.isWhitespace || $0 == "," })
        if !needsQuotes {
            self.init(key: key, encodedValue: value)
        } else if value.contains("'") {
            self.init(key: key, encodedValue: "\"\(value)\"")
        } else {
            self.init(key: key, encodedValue: "'\(value)'")
        }
    }

    init(_ key: String, _ value: Bool) {
        self.init(key: key, encodedValue: value.stringValue)
    }

    init(_ key: String, _ value: Int) {
        self.init(key: key, encodedValue: "\(value)")
    }

    init(_ key: String, _ value: Double) {
        self.init(key: key, encodedValue: "\(value)")
    }

    /// An array of strings, rendered as a quoted JSON array, e.g. `'["data-htmx-powered","style"]'`.
    /// Strings must not contain `'`, `"` or `\`.
    init(_ key: String, _ values: [String]) {
        self.init(key: key, encodedValue: "'[\(values.lazy.map { "\"\($0)\"" }.joined(separator: ","))]'")
    }

    /// An array of numbers, rendered as a quoted JSON array, e.g. `'[1001,1006]'`.
    init(_ key: String, _ values: [Int]) {
        self.init(key: key, encodedValue: "'[\(values.lazy.map { "\($0)" }.joined(separator: ","))]'")
    }
}
