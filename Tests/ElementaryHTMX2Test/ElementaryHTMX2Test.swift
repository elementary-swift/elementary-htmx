import Elementary
import ElementaryHTMX2
import TestUtilities
import Testing

@Suite struct ElementaryHTMX2Tests {
    @Test func rendersMethods() {
        HTMLAttributeAssertEqual(.hx.get("/test"), "hx-get", "/test")
        HTMLAttributeAssertEqual(.hx.post("/test"), "hx-post", "/test")
        HTMLAttributeAssertEqual(.hx.put("/test"), "hx-put", "/test")
        HTMLAttributeAssertEqual(.hx.patch("/test"), "hx-patch", "/test")
        HTMLAttributeAssertEqual(.hx.delete("/test"), "hx-delete", "/test")
    }

    @Test func rendersSwap() {
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML), "hx-swap", "innerHTML")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML), "hx-swap", "outerHTML")
        HTMLAttributeAssertEqual(.hx.swap(.textContent), "hx-swap", "textContent")
        HTMLAttributeAssertEqual(.hx.swap(.beforeBegin), "hx-swap", "beforebegin")
        HTMLAttributeAssertEqual(.hx.swap(.afterBegin), "hx-swap", "afterbegin")
        HTMLAttributeAssertEqual(.hx.swap(.beforeEnd), "hx-swap", "beforeend")
        HTMLAttributeAssertEqual(.hx.swap(.afterEnd), "hx-swap", "afterend")
        HTMLAttributeAssertEqual(.hx.swap(.delete), "hx-swap", "delete")
        HTMLAttributeAssertEqual(.hx.swap(.none), "hx-swap", "none")
    }

    @Test func rendersSwapModifiers() {
        HTMLAttributeAssertEqual(.hx.swap(.innerHTML.transition(true)), "hx-swap", "innerHTML transition:true")
        HTMLAttributeAssertEqual(.hx.swap(.outerHTML.swap("1s").settle("10ms")), "hx-swap", "outerHTML swap:1s settle:10ms")
        HTMLAttributeAssertEqual(.hx.swap(.textContent.swap("1s").settle("10ms")), "hx-swap", "textContent swap:1s settle:10ms")
        HTMLAttributeAssertEqual(.hx.swap(.default.transition(true)), "hx-swap", "transition:true")
    }

    @Test func rendersSelectOOB() {
        HTMLAttributeAssertEqual(.hx.selectOOB("#test"), "hx-select-oob", "#test")
        HTMLAttributeAssertEqual(.hx.selectOOB("#test", .innerHTML), "hx-select-oob", "#test:innerHTML")
    }

    @Test func rendersSwapOOB() {
        HTMLAttributeAssertEqual(.hx.swapOOB(true), "hx-swap-oob", "true")
        HTMLAttributeAssertEqual(.hx.swapOOB(.innerHTML), "hx-swap-oob", "innerHTML")
        HTMLAttributeAssertEqual(.hx.swapOOB(.innerHTML, "#test"), "hx-swap-oob", "innerHTML:#test")
    }

    @Test func rendersTrigger() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click)), "hx-trigger", "click")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.intersect)), "hx-trigger", "intersect")
        HTMLAttributeAssertEqual(.hx.trigger(.every("1s")), "hx-trigger", "every 1s")
    }

    @Test func rendersTriggerModifiers() {
        HTMLAttributeAssertEqual(.hx.trigger(.event(.click).delay("1s").consume()), "hx-trigger", "click delay:1s consume")
        HTMLAttributeAssertEqual(.hx.trigger(.event(.intersect).once()), "hx-trigger", "intersect once")
    }

    @Test func rendersDisable() {
        HTMLAttributeAssertEqual(.hx.disable, "hx-disable", nil)
    }
}

@Suite struct ElementaryHTMX2ElementTests {
    @Test func rendersPartial() {
        #expect(
            hxPartial(.hx.target("#notifications")) { "3 new messages" }.render()
                == ##"<hx-partial hx-target="#notifications">3 new messages</hx-partial>"##
        )
        #expect(
            hxPartial(.hx.target("#user-status"), .hx.swap(.outerHTML)) { span(.id("user-status")) { "Online" } }.render()
                == ##"<hx-partial hx-target="#user-status" hx-swap="outerHTML"><span id="user-status">Online</span></hx-partial>"##
        )
        #expect(
            hxPartial(.id("alerts")) { "Saved successfully!" }.render()
                == ##"<hx-partial id="alerts">Saved successfully!</hx-partial>"##
        )
    }
}
