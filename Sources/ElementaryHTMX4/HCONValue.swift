import Elementary

/// Options written in htmx's [HCON](https://four.htmx.org/docs/hcon-guide) notation, e.g. the modifiers in
/// `.hx.swap(.outerHTML, [.transition(true), .swap("1s")])`.
///
/// Each attribute offers the entries that apply to it. Any other key can be set with `.init(key, value)`,
/// and dotted keys set nested options, e.g. `.init("sse.reconnectDelay", "1s")`.
public struct HCONValue<Scope>: Sendable, ExpressibleByArrayLiteral {
    public let rawValue: String

    /// No entries. Used as the default for optional modifiers.
    @inlinable
    public init() {
        rawValue = ""
    }

    @inlinable
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

    @inlinable
    public init(arrayLiteral entries: Entry...) {
        self.init(entries)
    }

    @inlinable
    public var isEmpty: Bool { rawValue.isEmpty }

    /// A `key:value` pair, or a bare `key` flag. Dotted keys like `sse.reconnectDelay` set nested options.
    public struct Entry: Sendable {
        public var key: String
        /// The HCON-encoded value, including quotes if needed. `nil` for a bare flag.
        public private(set) var value: String?

        @usableFromInline
        init(key: String, encodedValue: String?) {
            self.key = key
            self.value = encodedValue
        }
    }
}

public extension HCONValue.Entry {
    /// A bare flag, e.g. `once`. HCON reads a key without a value as `true`.
    @inlinable
    init(_ key: String) {
        self.init(key: key, encodedValue: nil)
    }

    /// A string value. HCON reads a bare value up to whitespace or a comma, so values that contain
    /// whitespace or commas, are empty, or start with a quote or `<` are quoted.
    @inlinable
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

    @inlinable
    init(_ key: String, _ value: Bool) {
        self.init(key: key, encodedValue: value.stringValue)
    }

    @inlinable
    init(_ key: String, _ value: Int) {
        self.init(key: key, encodedValue: "\(value)")
    }

    @inlinable
    init(_ key: String, _ value: Double) {
        self.init(key: key, encodedValue: "\(value)")
    }

    /// An array of strings, rendered as a quoted JSON array, e.g. `'["data-htmx-powered","style"]'`.
    /// Strings must not contain `'`, `"` or `\`.
    @inlinable
    init(_ key: String, _ values: [String]) {
        self.init(key: key, encodedValue: "'[\(values.lazy.map { "\"\($0)\"" }.joined(separator: ","))]'")
    }

    /// An array of numbers, rendered as a quoted JSON array, e.g. `'[1001,1006]'`.
    @inlinable
    init(_ key: String, _ values: [Int]) {
        self.init(key: key, encodedValue: "'[\(values.lazy.map { "\($0)" }.joined(separator: ","))]'")
    }
}
