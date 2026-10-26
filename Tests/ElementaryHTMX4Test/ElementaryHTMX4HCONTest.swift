import Elementary
import ElementaryHTMX4
import Testing

@Suite struct ElementaryHTMX4HCONTests {
    typealias Config = HTMLAttributeValue.HTMX.HCON<HTMLAttributeValue.HTMX.GlobalConfig>
    typealias RequestConfig = HTMLAttributeValue.HTMX.HCON<HTMLAttributeValue.HTMX.RequestConfig>

    @Test func rendersEntries() {
        #expect(Config([]).rawValue == "")
        #expect(Config([.init("defaultSwap", "outerHTML")]).rawValue == "defaultSwap:outerHTML")
        #expect(([.init("a", "1"), .init("b.c", "x")] as Config).rawValue == "a:1 b.c:x")
    }

    @Test func quotesValues() {
        #expect(Config([.init("k", "")]).rawValue == "k:" + "''")
        #expect(Config([.init("k", "a b")]).rawValue == "k:" + "'a b'")
        #expect(Config([.init("k", "a,b")]).rawValue == "k:" + "'a,b'")
        #expect(Config([.init("k", #"["a","b"]"#)]).rawValue == "k:" + #"'["a","b"]'"#)
        #expect(Config([.init("k", #"["a"]"#)]).rawValue == "k:" + #"["a"]"#)
        #expect(Config([.init("k", "it's")]).rawValue == "k:" + "it's")
        #expect(Config([.init("k", "it's a")]).rawValue == "k:" + #""it's a""#)
        #expect(Config([.init("k", "'x'")]).rawValue == "k:" + #""'x'""#)
        #expect(Config([.init("k", "<x/>")]).rawValue == "k:" + "'<x/>'")
        #expect(Config([.init("k", "[hx-morph-skip]")]).rawValue == "k:" + "[hx-morph-skip]")
    }

    @Test func rendersTypedValues() {
        #expect(Config([.init("a", true), .init("b", 5), .init("c", 0.5)]).rawValue == "a:true b:5 c:0.5")
        #expect(Config([.init("a", ["x", "y"]), .init("b", [1, 2])]).rawValue == #"a:'["x","y"]' b:'[1,2]'"#)
        #expect(Config([.init("a", ["x"]), .init("b", [1])]).rawValue == #"a:'["x"]' b:'[1]'"#)
    }

    @Test func encodesValueOnCreate() {
        #expect(Config.Entry("k", "a b").value == "'a b'")
        #expect(Config.Entry("k", "x").value == "x")
        #expect(Config.Entry("k", true).value == "true")
        #expect(Config.Entry("k", [1, 2]).value == "'[1,2]'")
    }

    @Test func rendersAllOptions() {
        let config: Config = [
            .transitions(true),
            .history(false),
            .history("reload"),
            .mode("cors"),
            .defaultSwap(.outerHTML),
            .allowEmptySwapAfterOOB(true),
            .includeIndicatorCSS(false),
            .defaultTimeout(5000),
            .extensions("sse,ws"),
            .morphIgnore(["data-htmx-powered", "style"]),
            .noSwap(["204", "304", "4xx", "5xx"]),
            .implicitInheritance(true),
            .inlineScriptNonce("abc"),
        ]
        #expect(
            config.rawValue
                == #"transitions:true history:false history:reload mode:cors defaultSwap:outerHTML allowEmptySwapAfterOOB:true includeIndicatorCSS:false defaultTimeout:5000 extensions:'sse,ws' morphIgnore:'["data-htmx-powered","style"]' noSwap:'["204","304","4xx","5xx"]' implicitInheritance:true inlineScriptNonce:abc"#
        )
    }

    @Test func rendersRequestOptions() {
        let config: RequestConfig = [
            .timeout("5s"),
            .credentials("include"),
            .cache("no-cache"),
            .redirect("follow"),
            .referrer("no-referrer"),
            .integrity("sha384-abc"),
            .validate(true),
            .init("custom", "x"),
        ]
        #expect(
            config.rawValue
                == "timeout:5s credentials:include cache:no-cache redirect:follow referrer:no-referrer integrity:sha384-abc validate:true custom:x"
        )
    }
}
