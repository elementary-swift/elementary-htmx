import Elementary

public extension HTMLTag {
    enum hxPartial: HTMLTrait.Paired { public static let name = "hx-partial" }
}

/// A server-sent swap command that htmx removes from the response and swaps into its target.
///
/// Set the target with `.hx.target(...)` or `.id(...)`, and optionally the swap style with `.hx.swap(...)`.
/// See the [htmx reference](https://htmx.org/attributes/hx-partial/) for more information.
public typealias hxPartial<Content: HTML> = HTMLElement<HTMLTag.hxPartial, Content>
