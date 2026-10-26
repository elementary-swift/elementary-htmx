import Elementary

public extension HTMLAttributeValue.HTMX {
    /// `key:value` entries rendered as [HCON](https://four.htmx.org/docs/hcon-guide), htmx's config notation.
    ///
    /// `Scope` is a phantom type that selects which typed entries are available,
    /// e.g. ``GlobalConfig`` for `meta(htmxConfig:)` and ``RequestConfig`` for `.hx.config(...)`.
    /// Any key can be set with `.init(key, value)`. Dotted keys set nested options, e.g. `.init("sse.reconnectDelay", "1s")`.
    struct HCON<Scope>: Sendable, ExpressibleByArrayLiteral {
        public var entries: [Entry]

        public init(_ entries: [Entry]) {
            self.entries = entries
        }

        public init(arrayLiteral entries: Entry...) {
            self.entries = entries
        }

        /// A `key:value` pair. The value is encoded for HCON when the entry is created.
        ///
        /// Keys are rendered as-is, so dotted keys like `sse.reconnectDelay` set nested options.
        public struct Entry: Sendable {
            public var key: String
            /// The HCON-encoded value, including quotes if needed.
            public private(set) var value: String

            init(key: String, encodedValue: String) {
                self.key = key
                self.value = encodedValue
            }
        }

        public var rawValue: String {
            var result = ""
            for entry in entries {
                if !result.isEmpty {
                    result.append(" ")
                }
                result.append(entry.key)
                result.append(":")
                result.append(entry.value)
            }
            return result
        }
    }

    /// The scope for the global htmx config in `meta(htmxConfig:)`.
    /// See the [htmx config reference](https://four.htmx.org/reference/config/htmx-config).
    enum GlobalConfig {}

    /// The scope for per-request config in `.hx.config(...)`.
    /// See the [hx-config reference](https://four.htmx.org/reference/attributes/hx-config).
    enum RequestConfig {}
}

public extension HTMLAttributeValue.HTMX.HCON.Entry {
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
