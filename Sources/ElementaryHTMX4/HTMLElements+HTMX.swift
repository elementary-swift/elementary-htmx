import Elementary

public extension HTMLTag {
    enum hxPartial: HTMLTrait.Paired { public static let name = "hx-partial" }
}

/// A server-sent swap command that htmx removes from the response and swaps into its target.
///
/// Set the target with `.hx.target(...)` or `.id(...)`, and optionally the swap style with `.hx.swap(...)`.
/// See the [htmx reference](https://four.htmx.org/reference/tags/hx-partial) for more information.
public typealias hxPartial<Content: HTML> = HTMLElement<HTMLTag.hxPartial, Content>

public extension HTMLVoidElement where Tag == HTMLTag.meta {
    /// Creates a `<meta name="htmx-config">` tag with the config rendered as HCON.
    ///
    /// ```swift
    /// meta(htmxConfig: [.defaultSwap(.outerHTML), .implicitInheritance(true)])
    /// ```
    init(htmxConfig config: HTMLAttributeValue.HTMX.HCON<HTMLAttributeValue.HTMX.GlobalConfig>) {
        self.init(.name("htmx-config"), .content(config.rawValue))
    }
}
