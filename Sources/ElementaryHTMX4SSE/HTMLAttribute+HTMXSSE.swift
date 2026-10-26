import Elementary
import ElementaryHTMX4

extension HTMLAttribute.hx {
    /// A namespace for the `hx-sse` extension attributes.
    /// See the [hx-sse reference](https://four.htmx.org/extensions/hx-sse) for more information.
    public enum sse {}
}

extension HTMLAttribute.hx.sse {
    public static func connect(_ url: String) -> HTMLAttribute<Tag> {
        .init(name: "hx-sse:connect", value: url)
    }

    /// Closes the connection when a named event with this name arrives.
    public static func close(_ eventName: String) -> HTMLAttribute<Tag> {
        .init(name: "hx-sse:close", value: eventName)
    }
}
