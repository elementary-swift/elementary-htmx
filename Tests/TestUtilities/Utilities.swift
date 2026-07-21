import Elementary
import Testing

public func HTMLAttributeAssertEqual(
    _ attribute: HTMLAttribute<HTMLTag.div>,
    _ name: String,
    _ value: String?,
    sourceLocation: SourceLocation = #_sourceLocation
) {
    #expect(name == attribute.name, sourceLocation: sourceLocation)
    #expect(value == attribute.value, sourceLocation: sourceLocation)
}
