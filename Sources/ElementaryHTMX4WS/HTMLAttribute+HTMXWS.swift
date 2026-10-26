import Elementary
import ElementaryHTMX4

extension HTMLAttribute.hx {
    /// A namespace for the `hx-ws` extension attributes.
    /// See the [hx-ws reference](https://four.htmx.org/extensions/hx-ws) for more information.
    public enum ws {}
}

extension HTMLAttribute.hx.ws {
    public static func connect(_ url: String) -> HTMLAttribute<Tag> {
        .init(name: "hx-ws:connect", value: url)
    }

    /// Sends the element's values over the nearest `hx-ws:connect` connection.
    public static var send: HTMLAttribute<Tag> {
        .init(name: "hx-ws:send", value: nil)
    }
}
