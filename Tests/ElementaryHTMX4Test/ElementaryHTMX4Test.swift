import Elementary
import ElementaryHTMX4
import TestUtilities
import Testing

@Suite struct ElementaryHTMX4Tests {
    @Test func rendersMethods() {
        HTMLAttributeAssertEqual(.hx.get("/test"), "hx-get", "/test")
        HTMLAttributeAssertEqual(.hx.post("/test"), "hx-post", "/test")
        HTMLAttributeAssertEqual(.hx.put("/test"), "hx-put", "/test")
        HTMLAttributeAssertEqual(.hx.patch("/test"), "hx-patch", "/test")
        HTMLAttributeAssertEqual(.hx.delete("/test"), "hx-delete", "/test")
        HTMLAttributeAssertEqual(.hx.query("/test"), "hx-query", "/test")
    }

    @Test func rendersActionAndMethod() {
        HTMLAttributeAssertEqual(.hx.action("/test"), "hx-action", "/test")
        HTMLAttributeAssertEqual(.hx.method(.get), "hx-method", "get")
        HTMLAttributeAssertEqual(.hx.method(.post), "hx-method", "post")
        HTMLAttributeAssertEqual(.hx.method(.put), "hx-method", "put")
        HTMLAttributeAssertEqual(.hx.method(.patch), "hx-method", "patch")
        HTMLAttributeAssertEqual(.hx.method(.delete), "hx-method", "delete")
        HTMLAttributeAssertEqual(.hx.method(.query), "hx-method", "query")
    }

    @Test func rendersSwap() {
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML), "hx-swap", "innerHTML")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML), "hx-swap", "outerHTML")
        HTMLAttributeAssertEqual(.hx.swap(.outerSync), "hx-swap", "outerSync")
        HTMLAttributeAssertEqual(.hx.swap(.textContent), "hx-swap", "textContent")
        HTMLAttributeAssertEqual(.hx.swap(.beforeBegin), "hx-swap", "beforebegin")
        HTMLAttributeAssertEqual(.hx.swap(.before), "hx-swap", "before")
        HTMLAttributeAssertEqual(.hx.swap(.afterBegin), "hx-swap", "afterbegin")
        HTMLAttributeAssertEqual(.hx.swap(.prepend), "hx-swap", "prepend")
        HTMLAttributeAssertEqual(.hx.swap(.beforeEnd), "hx-swap", "beforeend")
        HTMLAttributeAssertEqual(.hx.swap(.append), "hx-swap", "append")
        HTMLAttributeAssertEqual(.hx.swap(.afterEnd), "hx-swap", "afterend")
        HTMLAttributeAssertEqual(.hx.swap(.after), "hx-swap", "after")
        HTMLAttributeAssertEqual(.hx.swap(.innerMorph), "hx-swap", "innerMorph")
        HTMLAttributeAssertEqual(.hx.swap(.outerMorph), "hx-swap", "outerMorph")
        HTMLAttributeAssertEqual(.hx.swap(.delete), "hx-swap", "delete")
        HTMLAttributeAssertEqual(.hx.swap(.none), "hx-swap", "none")
        HTMLAttributeAssertEqual(.hx.swap("upsert"), "hx-swap", "upsert")
    }

    @Test func rendersSwapModifiers() {
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML, [.transition(true)]), "hx-swap", "innerHTML transition:true")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML, [.swap("1s"), .settle("10ms")]), "hx-swap", "outerHTML swap:1s settle:10ms")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML, [.ignoreTitle(true)]), "hx-swap", "outerHTML ignoreTitle:true")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML, [.strip(true)]), "hx-swap", "innerHTML strip:true")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML, [.focusScroll(true)]), "hx-swap", "innerHTML focusScroll:true")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML, [.swapEmpty(true)]), "hx-swap", "outerHTML swapEmpty:true")
        HTMLAttributeAssertEqual(.hx.swap(.beforeEnd, [.scroll(.bottom)]), "hx-swap", "beforeend scroll:bottom")
        HTMLAttributeAssertEqual(
            .hx.swap(.innerHTML, [.scroll(.top), .scrollTarget("#other")]),
            "hx-swap",
            "innerHTML scroll:top scrollTarget:#other"
        )
        HTMLAttributeAssertEqual(
            .hx.swap(.innerHTML, [.show(.top), .showTarget("closest .container")]),
            "hx-swap",
            "innerHTML show:top showTarget:'closest .container'"
        )
        HTMLAttributeAssertEqual(.hx.swap([.show(.none)]), "hx-swap", "show:none")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML, [.target("#results")]), "hx-swap", "innerHTML target:#results")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML, []), "hx-swap", "innerHTML")
        HTMLAttributeAssertEqual(.hx.swap("upsert", [.init("key", "id")]), "hx-swap", "upsert key:id")
    }

    @Test func rendersTargetAndSelect() {
        HTMLAttributeAssertEqual(.hx.target("next output"), "hx-target", "next output")
        HTMLAttributeAssertEqual(.hx.select("#info-detail"), "hx-select", "#info-detail")
    }

    @Test func rendersSelectOOB() {
        HTMLAttributeAssertEqual(.hx.selectOOB("#test"), "hx-select-oob", "#test")
        HTMLAttributeAssertEqual(.hx.selectOOB("#test", .afterBegin), "hx-select-oob", "#test:afterbegin")
        #expect(
            div(.hx.selectOOB("#alert"), .hx.selectOOB("#sidebar", .afterBegin)) {}.render()
                == ##"<div hx-select-oob="#alert,#sidebar:afterbegin"></div>"##
        )
    }

    @Test func rendersSwapOOB() {
        HTMLAttributeAssertEqual(.hx.swapOOB(true), "hx-swap-oob", "true")
        HTMLAttributeAssertEqual(.hx.swapOOB(.beforeEnd), "hx-swap-oob", "beforeend")
        HTMLAttributeAssertEqual(.hx.swapOOB(.beforeEnd, "#table tbody"), "hx-swap-oob", "beforeend:#table tbody")
        HTMLAttributeAssertEqual(
            .hx.swapOOB(.beforeEnd, [.target("#table tbody"), .swap("1s")]),
            "hx-swap-oob",
            "beforeend target:'#table tbody' swap:1s"
        )
    }

    @Test func rendersTrigger() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click)), "hx-trigger", "click")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.load)), "hx-trigger", "load")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.revealed)), "hx-trigger", "revealed")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.intersect)), "hx-trigger", "intersect")
        HTMLAttributeAssertEqual(.hx.trigger(.event("productsUpdated"), [.from("body")]), "hx-trigger", "productsUpdated from:body")
        HTMLAttributeAssertEqual(.hx.trigger(.every("1s")), "hx-trigger", "every 1s")
        HTMLAttributeAssertEqual(.hx.trigger(.every("1s", filter: "someConditional")), "hx-trigger", "every 1s [someConditional]")
    }

    @Test func rendersTriggerModifiers() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click), [.delay("1s"), .consume]), "hx-trigger", "click delay:1s consume")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.intersect), [.once]), "hx-trigger", "intersect once")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.input), [.changed, .throttle("500ms")]), "hx-trigger", "input changed throttle:500ms")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.submit), [.prevent, .stop]), "hx-trigger", "submit prevent stop")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click), [.halt, .capture, .passive]), "hx-trigger", "click halt capture passive")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click), [.target(".a, .b")]), "hx-trigger", "click target:'.a, .b'")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.submit), [.from("closest form")]), "hx-trigger", "submit from:'closest form'")
        HTMLAttributeAssertEqual(
            .hx.trigger(.event(.intersect), [.root("#scroller"), .rootMargin("100px"), .threshold(0.5)]),
            "hx-trigger",
            "intersect root:#scroller rootMargin:100px threshold:0.5"
        )
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click), []), "hx-trigger", "click")
    }

    @Test func rendersTriggerFilter() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.keyup, filter: "key=='Enter'")), "hx-trigger", "keyup[key=='Enter']")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click, filter: "shiftKey"), [.once]), "hx-trigger", "click[shiftKey] once")
        HTMLAttributeAssertEqual(.hx.trigger(.event("custom", filter: "ok")), "hx-trigger", "custom[ok]")
    }

    @Test func mergesTriggers() {
        #expect(
            div(.hx.trigger(.event(.input), [.delay("500ms")]), .hx.trigger(.event(.keyup, filter: "key=='Enter'"))) {}.render()
                == #"<div hx-trigger="input delay:500ms, keyup[key=='Enter']"></div>"#
        )
    }

    @Test func rendersConfirm() {
        HTMLAttributeAssertEqual(.hx.confirm("Are you sure?"), "hx-confirm", "Are you sure?")
        HTMLAttributeAssertEqual(.hx.confirm("js:swalConfirm()"), "hx-confirm", "js:swalConfirm()")
    }

    @Test func rendersOn() {
        HTMLAttributeAssertEqual(.hx.on(.click, "alert('hi')"), "hx-on:click", "alert('hi')")
        HTMLAttributeAssertEqual(.hx.on(.keyup, "go()"), "hx-on:keyup", "go()")
        HTMLAttributeAssertEqual(.hx.on(.submit, "go()"), "hx-on:submit", "go()")
        HTMLAttributeAssertEqual(.hx.on("htmx:after:swap", "go()"), "hx-on:htmx:after:swap", "go()")
        HTMLAttributeAssertEqual(.hx.on(":before:request", "go()"), "hx-on::before:request", "go()")
        HTMLAttributeAssertEqual(.hx.on("load -> this.showModal()"), "hx-on", "load -> this.showModal()")
    }

    @Test func rendersData() {
        HTMLAttributeAssertEqual(.hx.vals(#"{"draft": true}"#), "hx-vals", #"{"draft": true}"#)
        HTMLAttributeAssertEqual(.hx.include("[name='email']"), "hx-include", "[name='email']")
        HTMLAttributeAssertEqual(.hx.headers(#"{"X-Widget-Id": "42"}"#), "hx-headers", #"{"X-Widget-Id": "42"}"#)
        HTMLAttributeAssertEqual(
            .hx.vals([.init("draft", true), .init("count", 2), .init("name", "a b")]),
            "hx-vals",
            "draft:true count:2 name:'a b'"
        )
        HTMLAttributeAssertEqual(.hx.headers([.init("X-Widget-Id", "42")]), "hx-headers", "X-Widget-Id:42")
        HTMLAttributeAssertEqual(.hx.encoding("multipart/form-data"), "hx-encoding", "multipart/form-data")
    }

    @Test func rendersHistory() {
        HTMLAttributeAssertEqual(.hx.pushURL(true), "hx-push-url", "true")
        HTMLAttributeAssertEqual(.hx.pushURL("/account/home"), "hx-push-url", "/account/home")
        HTMLAttributeAssertEqual(.hx.replaceURL(false), "hx-replace-url", "false")
        HTMLAttributeAssertEqual(.hx.replaceURL("/account/home"), "hx-replace-url", "/account/home")
        HTMLAttributeAssertEqual(.hx.historyElt, "hx-history-elt", nil)
    }

    @Test func rendersBoost() {
        HTMLAttributeAssertEqual(.hx.boost(true), "hx-boost", "true")
        HTMLAttributeAssertEqual(.hx.boost(false), "hx-boost", "false")
        HTMLAttributeAssertEqual(
            .hx.boost([.swap(.outerSync), .select("#main"), .target("#main")]),
            "hx-boost",
            "swap:outerSync select:#main target:#main"
        )
        HTMLAttributeAssertEqual(
            .hx.boost([.swap(.innerHTML, [.strip(true)]), .target("#sidebar")]),
            "hx-boost",
            "swap:'innerHTML strip:true' target:#sidebar"
        )
    }

    @Test func rendersAdvanced() {
        HTMLAttributeAssertEqual(.hx.indicator("#spinner"), "hx-indicator", "#spinner")
        HTMLAttributeAssertEqual(.hx.status("422", [.target("#errors")]), "hx-status:422", "target:#errors")
        HTMLAttributeAssertEqual(.hx.status("5xx", [.swap(.none)]), "hx-status:5xx", "swap:none")
        HTMLAttributeAssertEqual(
            .hx.status("422", [.swap(.innerHTML), .target("#errors"), .select("#validation-errors")]),
            "hx-status:422",
            "swap:innerHTML target:#errors select:#validation-errors"
        )
        HTMLAttributeAssertEqual(
            .hx.status("201", [.push("/items/new"), .replace(false), .transition(true)]),
            "hx-status:201",
            "push:/items/new replace:false transition:true"
        )
        HTMLAttributeAssertEqual(.hx.status("500", [.push(false)]), "hx-status:500", "push:false")
        HTMLAttributeAssertEqual(.hx.status("301", [.replace("/new-location")]), "hx-status:301", "replace:/new-location")
        HTMLAttributeAssertEqual(.hx.validate(true), "hx-validate", "true")
        HTMLAttributeAssertEqual(.hx.disable("closest fieldset"), "hx-disable", "closest fieldset")
        HTMLAttributeAssertEqual(.hx.ignore, "hx-ignore", nil)
        HTMLAttributeAssertEqual(.hx.preserve, "hx-preserve", nil)
        HTMLAttributeAssertEqual(.hx.morphSkip, "hx-morph-skip", nil)
        HTMLAttributeAssertEqual(.hx.morphSkipChildren, "hx-morph-skip-children", nil)
        HTMLAttributeAssertEqual(.hx.config([.timeout("5s"), .cache("no-cache")]), "hx-config", "timeout:5s cache:no-cache")
    }

    @Test func rendersSync() {
        HTMLAttributeAssertEqual(.hx.sync("closest form"), "hx-sync", "closest form")
        HTMLAttributeAssertEqual(.hx.sync("closest form", .abort), "hx-sync", "closest form:abort")
        HTMLAttributeAssertEqual(.hx.sync("this", .replace), "hx-sync", "this:replace")
        HTMLAttributeAssertEqual(.hx.sync("this", .drop), "hx-sync", "this:drop")
        HTMLAttributeAssertEqual(.hx.sync("this", .queue), "hx-sync", "this:queue")
        HTMLAttributeAssertEqual(.hx.sync("this", .queueFirst), "hx-sync", "this:queue first")
        HTMLAttributeAssertEqual(.hx.sync("this", .queueLast), "hx-sync", "this:queue last")
        HTMLAttributeAssertEqual(.hx.sync("this", .queueAll), "hx-sync", "this:queue all")
        HTMLAttributeAssertEqual(.hx.sync(.replace), "hx-sync", "replace")
    }
}

/// The modifier chains are deprecated in favor of HCON modifier entries, but still render the same values.
@Suite struct ElementaryHTMX4DeprecatedChainTests {
    @available(*, deprecated)
    @Test func rendersDeprecatedSwapChains() {
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML.transition(true)), "hx-swap", "innerHTML transition:true")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML.swap("1s").settle("10ms")), "hx-swap", "outerHTML swap:1s settle:10ms")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML.ignoreTitle(true)), "hx-swap", "outerHTML ignoreTitle:true")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML.strip(true)), "hx-swap", "innerHTML strip:true")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML.focusScroll(true)), "hx-swap", "innerHTML focusScroll:true")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML.swapEmpty(true)), "hx-swap", "outerHTML swapEmpty:true")
        HTMLAttributeAssertEqual(.hx.swap(.beforeEnd.scroll(.bottom)), "hx-swap", "beforeend scroll:bottom")
        HTMLAttributeAssertEqual(
            .hx.swap(.innerHTML.scroll(.top).scrollTarget("#other")),
            "hx-swap",
            "innerHTML scroll:top scrollTarget:#other"
        )
        HTMLAttributeAssertEqual(
            .hx.swap(.innerHTML.show(.top).showTarget("'closest .container'")),
            "hx-swap",
            "innerHTML show:top showTarget:'closest .container'"
        )
        HTMLAttributeAssertEqual(.hx.swap(.default.show(.none)), "hx-swap", "show:none")
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML.target("#results")), "hx-swap", "innerHTML target:#results")
        HTMLAttributeAssertEqual(.hx.swap(.inherited, .outerHTML.transition(true)), "hx-swap:inherited", "outerHTML transition:true")
    }

    @available(*, deprecated)
    @Test func rendersDeprecatedTriggerChains() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click).delay("1s").consume()), "hx-trigger", "click delay:1s consume")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.intersect).once()), "hx-trigger", "intersect once")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.input).changed().throttle("500ms")), "hx-trigger", "input changed throttle:500ms")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.submit).prevent().stop()), "hx-trigger", "submit prevent stop")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click).halt().capture().passive()), "hx-trigger", "click halt capture passive")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click).target("'.a, .b'")), "hx-trigger", "click target:'.a, .b'")
        HTMLAttributeAssertEqual(
            .hx.trigger(.event(.intersect).root("#scroller").rootMargin("100px").threshold(0.5)),
            "hx-trigger",
            "intersect root:#scroller rootMargin:100px threshold:0.5"
        )
    }

    @available(*, deprecated)
    @Test func rendersDeprecatedTriggerFilter() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.keyup).filter("key=='Enter'")), "hx-trigger", "keyup[key=='Enter']")
        HTMLAttributeAssertEqual(.hx.trigger(.every("1s").filter("ok")), "hx-trigger", "every 1s [ok]")
        HTMLAttributeAssertEqual(.hx.trigger(.event("productsUpdated").from("body")), "hx-trigger", "productsUpdated from:body")
        HTMLAttributeAssertEqual(
            .hx.trigger(.event(.click).once().filter("shiftKey")),
            "hx-trigger",
            "click[shiftKey] once"
        )
    }

    @available(*, deprecated)
    @Test func mergesDeprecatedTriggers() {
        #expect(
            div(.hx.trigger(.event(.input).delay("500ms")), .hx.trigger(.event(.keyup).filter("key=='Enter'"))) {}.render()
                == #"<div hx-trigger="input delay:500ms, keyup[key=='Enter']"></div>"#
        )
    }
}

@Suite struct ElementaryHTMX4InheritanceTests {
    @Test func rendersModifiers() {
        HTMLAttributeAssertEqual(.hx.confirm(.inherited, "Are you sure?"), "hx-confirm:inherited", "Are you sure?")
        HTMLAttributeAssertEqual(.hx.vals(.append, #"{"source": "btn"}"#), "hx-vals:append", #"{"source": "btn"}"#)
        HTMLAttributeAssertEqual(.hx.indicator(.inheritedAppend, "#spinner"), "hx-indicator:inherited:append", "#spinner")
        HTMLAttributeAssertEqual(.hx.target(nil, "#out"), "hx-target", "#out")
    }

    @Test func rendersModifierOnEveryInheritableAttribute() {
        HTMLAttributeAssertEqual(.hx.get(.inherited, "/a"), "hx-get:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.post(.inherited, "/a"), "hx-post:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.put(.inherited, "/a"), "hx-put:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.patch(.inherited, "/a"), "hx-patch:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.delete(.inherited, "/a"), "hx-delete:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.query(.inherited, "/a"), "hx-query:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.action(.inherited, "/a"), "hx-action:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.method(.inherited, .post), "hx-method:inherited", "post")
        HTMLAttributeAssertEqual(.hx.trigger(.inherited, .event(.click)), "hx-trigger:inherited", "click")
        HTMLAttributeAssertEqual(.hx.trigger(.inherited, .every("1s")), "hx-trigger:inherited", "every 1s")
        HTMLAttributeAssertEqual(.hx.swap(.inherited, .outerHTML), "hx-swap:inherited", "outerHTML")
        HTMLAttributeAssertEqual(.hx.swap(.inherited, .outerHTML, [.swap("1s")]), "hx-swap:inherited", "outerHTML swap:1s")
        HTMLAttributeAssertEqual(.hx.swap(.inherited, [.transition(true)]), "hx-swap:inherited", "transition:true")
        HTMLAttributeAssertEqual(.hx.trigger(.inherited, .event(.click), [.once]), "hx-trigger:inherited", "click once")
        HTMLAttributeAssertEqual(.hx.target(.inherited, "#out"), "hx-target:inherited", "#out")
        HTMLAttributeAssertEqual(.hx.select(.inherited, "#main"), "hx-select:inherited", "#main")
        HTMLAttributeAssertEqual(.hx.selectOOB(.inherited, "#a", .innerHTML), "hx-select-oob:inherited", "#a:innerHTML")
        HTMLAttributeAssertEqual(.hx.vals(.inherited, "{}"), "hx-vals:inherited", "{}")
        HTMLAttributeAssertEqual(.hx.include(.inherited, "#x"), "hx-include:inherited", "#x")
        HTMLAttributeAssertEqual(.hx.headers(.inherited, "{}"), "hx-headers:inherited", "{}")
        HTMLAttributeAssertEqual(.hx.vals(.append, [.init("a", 1)]), "hx-vals:append", "a:1")
        HTMLAttributeAssertEqual(.hx.headers(.inherited, [.init("X-A", "1")]), "hx-headers:inherited", "X-A:1")
        HTMLAttributeAssertEqual(.hx.encoding(.inherited, "multipart/form-data"), "hx-encoding:inherited", "multipart/form-data")
        HTMLAttributeAssertEqual(.hx.pushURL(.inherited, true), "hx-push-url:inherited", "true")
        HTMLAttributeAssertEqual(.hx.pushURL(.inherited, "/a"), "hx-push-url:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.replaceURL(.inherited, false), "hx-replace-url:inherited", "false")
        HTMLAttributeAssertEqual(.hx.replaceURL(.inherited, "/a"), "hx-replace-url:inherited", "/a")
        HTMLAttributeAssertEqual(.hx.boost(.inherited, true), "hx-boost:inherited", "true")
        HTMLAttributeAssertEqual(.hx.boost(.inherited, [.target("#main")]), "hx-boost:inherited", "target:#main")
        HTMLAttributeAssertEqual(.hx.indicator(.inherited, "#s"), "hx-indicator:inherited", "#s")
        HTMLAttributeAssertEqual(.hx.status(.inherited, "5xx", [.swap(.none)]), "hx-status:5xx:inherited", "swap:none")
        HTMLAttributeAssertEqual(.hx.sync(.inherited, "this", .replace), "hx-sync:inherited", "this:replace")
        HTMLAttributeAssertEqual(.hx.sync(.inherited, .replace), "hx-sync:inherited", "replace")
        HTMLAttributeAssertEqual(.hx.validate(.inherited, true), "hx-validate:inherited", "true")
        HTMLAttributeAssertEqual(.hx.disable(.inherited, "this"), "hx-disable:inherited", "this")
        HTMLAttributeAssertEqual(.hx.config(.inherited, [.timeout("5s")]), "hx-config:inherited", "timeout:5s")
        HTMLAttributeAssertEqual(.hx.confirm(.inherited, "?"), "hx-confirm:inherited", "?")
    }

    @Test func passesOptionalModifier() {
        let modifier: HTMLAttributeValue.HTMX.InheritanceModifier? = nil
        HTMLAttributeAssertEqual(.hx.target(modifier, "#out"), "hx-target", "#out")
    }

    @Test func rendersOnParent() {
        #expect(
            div(.hx.confirm(.inherited, "Are you sure?")) {
                button(.hx.delete("/account")) { "Delete" }
            }.render()
                == #"<div hx-confirm:inherited="Are you sure?"><button hx-delete="/account">Delete</button></div>"#
        )
    }
}

@Suite struct ElementaryHTMX4ElementTests {
    @Test func rendersPartial() {
        #expect(
            hxPartial(.hx.target("#notifications")) { "3 new messages" }.render()
                == ##"<hx-partial hx-target="#notifications">3 new messages</hx-partial>"##
        )
        #expect(
            hxPartial(.hx.target("#messages"), .hx.swap(.beforeEnd)) { div { "New message" } }.render()
                == ##"<hx-partial hx-target="#messages" hx-swap="beforeend"><div>New message</div></hx-partial>"##
        )
        #expect(
            hxPartial(.id("alerts")) { "Saved successfully!" }.render()
                == ##"<hx-partial id="alerts">Saved successfully!</hx-partial>"##
        )
    }

    @Test func rendersMetaTag() {
        #expect(
            meta(htmxConfig: [.defaultSwap(.outerHTML), .implicitInheritance(true)]).render()
                == #"<meta name="htmx-config" content="defaultSwap:outerHTML implicitInheritance:true">"#
        )
    }
}
