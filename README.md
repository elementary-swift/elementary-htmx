# ElementaryHTMX: Hypertext web apps with Swift

**Ergonomic [htmx](https://htmx.org/) extensions for [Elementary](https://github.com/elementary-swift/elementary)**

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Felementary-swift%2Felementary-htmx%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/elementary-swift/elementary-htmx) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Felementary-swift%2Felementary-htmx%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/elementary-swift/elementary-htmx)

> [!IMPORTANT]
> `ElementaryHTMX` currently targets the htmx 2 API. Use the versioned modules (e.g. `ElementaryHTMX2`) to pin a specific htmx version.
>
> [htmx 4](https://four.htmx.org/announcements/2026-08-28-htmx-4.0.0-is-released) is supported by the `ElementaryHTMX4` module, see [htmx 4](#htmx-4).

```swift
import Elementary
import ElementaryHTMX

// first-class support for most htmx attributes
form(.hx.post("/items"), .hx.target("#list"), .hx.swap(.outerHTML)) {
    input(.type(.text), .name("item"), .value("New Item"))
    input(.type(.submit), .value("Add Item"))
}

div {
    button(.hx.delete("items/\(item.id)")) { "❌" }
    item.text
}

MyFragment(items: items)
    .attributes(.hx.swapOOB(.outerHTML, "#list"))

// server-sent swap commands with <hx-partial> (requires htmx 2.0.11 or later)
hxPartial(.hx.target("#notifications")) {
    "3 new messages"
}
```

```swift
import Elementary
import ElementaryHTMXSSE

// htmx Server-Sent Events extension
div(.hx.ext(.sse), .sse.connect("/time"), .sse.swap("message")) {
    "\(Date())"
}
```

```swift
import Elementary
import ElementaryHTMXWS

// htmx WebSockets extension
div(.hx.ext(.ws), .ws.connect("/echo")) {
    form(.ws.send) {
        input(.type(.text), .name("message"))
        button { "Send" }
    }
    div(.id("echo")) {}
}
```

```swift
import Elementary
import ElementaryHyperscript

// Hyperscript extension
button(.hyperscript("on click send hello to <form />")) {
    "Send"
}
```

## Play with it

The example apps use htmx 4 with the `ElementaryHTMX4` modules.

Check out the [Hummingbird example app](https://github.com/elementary-swift/elementary-htmx/tree/main/Examples/HummingbirdDemo).

Check out the [Vapor example app](https://github.com/elementary-swift/elementary-htmx/tree/main/Examples/VaporDemo).

## Documentation

The package brings the `.hx` syntax to all `HTMLElements` - providing a rich API for most [htmx 2 attributes](https://htmx.org/reference/), as well as the `hxPartial` element for [`<hx-partial>`](https://htmx.org/attributes/hx-partial/) (requires htmx 2.0.11 or later).

For htmx 2, there is also an `ElementaryHTMXSSE` module that adds the `.sse` syntax for the [Server-Sent Events extension](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md), as well as `ElementaryHTMXWS` to add the `.ws` syntax for the [WebSockets extension](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/ws/README.md).

### htmx versions

Each supported htmx major version has its own versioned modules:

| htmx | Core              | SSE                  | WebSockets          |
| ---- | ----------------- | -------------------- | ------------------- |
| v2   | `ElementaryHTMX2` | `ElementaryHTMX2SSE` | `ElementaryHTMX2WS` |
| v4   | `ElementaryHTMX4` | `ElementaryHTMX4SSE` | `ElementaryHTMX4WS` |

The unversioned `ElementaryHTMX`, `ElementaryHTMXSSE` and `ElementaryHTMXWS` modules re-export the current default version (htmx 2), so existing imports keep working. Depend on a versioned module if you want to stay on a specific htmx version when the default changes.

```swift
// Package.swift
.product(name: "ElementaryHTMX2", package: "elementary-htmx")
```

```swift
import Elementary
import ElementaryHTMX2
```

### htmx 4

- `ElementaryHTMX4` mirrors the [htmx 4 attributes](https://four.htmx.org/reference) by name.
- Modifiers and options are lists of entries, rendered and quoted as [HCON](https://four.htmx.org/docs/hcon-guide) for you. This covers `hx-swap` and `hx-trigger` modifiers, `hx-status`, `hx-boost`, `hx-vals`, `hx-headers`, `hx-config` and the `htmx-config` meta tag. Use `.init(key, value)` for anything without a helper.
- The [`hx-sse`](https://four.htmx.org/extensions/hx-sse) and [`hx-ws`](https://four.htmx.org/extensions/hx-ws) extensions are in `ElementaryHTMX4SSE` and `ElementaryHTMX4WS`, as `.hx.sse` and `.hx.ws` (`hx-sse:connect`, `hx-ws:send`, ...).

```swift
// Package.swift
.product(name: "ElementaryHTMX4", package: "elementary-htmx")
```

```swift
import Elementary
import ElementaryHTMX4

button(.hx.post("/clicked"), .hx.target("#output"), .hx.swap(.outerHTML)) { "Click Me" }
input(.name("q"), .hx.query("/search"), .hx.trigger(.event(.input), [.changed, .delay("500ms")]), .hx.target("#results"))

// modifiers, quoted for you: hx-trigger="submit from:'closest form'"
div(.hx.get("/preview"), .hx.trigger(.event(.submit), [.from("closest form")])) {}
div(.hx.get("/messages"), .hx.swap(.beforeEnd, [.scroll(.bottom), .settle("100ms")])) {}

// per-status overrides: hx-status:422="target:#errors select:#validation-errors"
form(.hx.post("/items"), .hx.status("422", [.target("#errors"), .select("#validation-errors")])) { ... }

// built-in morph swaps
div(.hx.get("/list"), .hx.swap(.innerMorph)) { ... }

// explicit inheritance: pass .inherited, .append or .inheritedAppend as the first argument
div(.hx.confirm(.inherited, "Are you sure?")) {   // hx-confirm:inherited="Are you sure?"
    button(.hx.delete("/account")) { "Delete My Account" }
    button(.hx.put("/account")) { "Update My Account" }
}
div(.hx.vals(.inherited, [.init("tenant", "acme")])) {
    button(.hx.post("/save"), .hx.vals(.append, [.init("source", "save-btn")])) { "Save" }
}

// multi-target updates with <hx-partial>
hxPartial(.hx.target("#messages"), .hx.swap(.beforeEnd)) { div { "New message" } }
hxPartial(.id("notifications")) { span { "5" } }

// <meta name="htmx-config" content="defaultSwap:outerHTML noSwap:'["204","304","4xx","5xx"]' my.option:42">
meta(htmxConfig: [.defaultSwap(.outerHTML), .noSwap(["204", "304", "4xx", "5xx"]), .init("my.option", "42")])

// hx-config="timeout:5s cache:no-cache"
button(.hx.get("/report"), .hx.config([.timeout("5s"), .cache("no-cache")])) { "Report" }
```

```swift
import Elementary
import ElementaryHTMX4
import ElementaryHTMX4SSE
import ElementaryHTMX4WS

// SSE (load hx-sse.js) and WebSockets (load hx-ws.js)
div(.hx.sse.connect("/events"), .hx.sse.close("done")) {}
div(.hx.ws.connect("/chat"), .hx.target("#messages"), .hx.swap(.beforeEnd)) {
    div(.id("messages")) {}
    form(.hx.ws.send) {
        input(.name("message"))
        button { "Send" }
    }
}

// extension config entries, globally or per connection
meta(htmxConfig: [.sse.reconnectDelay("1s"), .ws.reconnectMaxAttempts(5)])
div(.hx.sse.connect("/progress"), .hx.config([.sse.reconnect(false)])) {}
```

Upgrading from v2? htmx changed a lot in v4 (explicit inheritance, error responses are swapped, history, event names, SSE/WS attributes). See [What's new in htmx 4](https://four.htmx.org/docs/whats-new-in-htmx-4). On the Swift side, the v2-style modifier chains (`.outerHTML.transition(true)`, `.event(.click).once()`) still work in `ElementaryHTMX4` but are deprecated in favor of modifier entries.

### Hyperscript

The package also supports the [Hyperscript](https://hyperscript.org) `_` attribute as `.hyperscript`.

## Development

`swift test` runs the unit tests. `IntegrationTests/run.sh` runs the integration tests: it builds a small Hummingbird server that renders pages with `ElementaryHTMX4`, starts it, and checks with [Playwright](https://playwright.dev) in headless Chromium that a vendored copy of htmx 4.0.0 actually updates the DOM. It needs Swift and Node.js.

```bash
./IntegrationTests/run.sh
```

## Future directions

- Add module (or separate package?) for htmx Request and Response headers

PRs welcome.
