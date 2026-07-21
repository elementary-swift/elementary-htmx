import Elementary
import ElementaryHyperscript
import TestUtilities
import Testing

@Suite struct ElementaryHyperscriptTests {
    @Test func rendersScript() {
        HTMLAttributeAssertEqual(.hyperscript("on click send hello to <form />"), "_", "on click send hello to <form />")
    }
}
