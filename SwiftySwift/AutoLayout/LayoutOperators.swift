
import UIKit

// MARK: - Add Subview

/*
 The |+| operator is used to add subviews. Array can be used to add views so view hierarchy can be shown like this:
 
    v1 |+| [
        v2,
        v3 |+| [
            v4,
            v5
        ]
    ]
 */

precedencegroup AddSubviewsPrecendence {
    higherThan: AssignmentPrecedence
    lowerThan:  TernaryPrecedence
}

infix operator |+| : AddSubviewsPrecendence

@discardableResult public func |+|<T: UIView>(lhs: T, rhs: UIView) -> UIView {
    lhs.addSubview(rhs)
    rhs.translatesAutoresizingMaskIntoConstraints = false
    return lhs
}

@discardableResult public func |+|<T: UIStackView>(lhs: T, rhs: UIView) -> UIView {
    lhs.addArrangedSubview(rhs)
    return lhs
}

@discardableResult public func |+|<T: UIView>(lhs: T, rhs: [UIView]) -> UIView {
    rhs.forEach { $0.translatesAutoresizingMaskIntoConstraints = false; lhs.addSubview($0) }
    return lhs
}

@discardableResult public func |+|<T: UIStackView>(lhs: T, rhs: [UIView]) -> UIView {
    rhs.forEach { lhs.addArrangedSubview($0) }
    return lhs
}

// MARK: - LayoutConstraint

precedencegroup LayoutConstraintPrecendence {
    higherThan: AssignmentPrecedence
    lowerThan:  TernaryPrecedence
}

infix operator |=| : LayoutConstraintPrecendence
infix operator |>| : LayoutConstraintPrecendence
infix operator |<| : LayoutConstraintPrecendence

// MARK: - LayoutConstraint: LayoutDataConvertible |_| LayoutDataConvertible

@discardableResult public func |=|(lhs: LayoutDataConvertible, rhs: LayoutDataConvertible) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .equal, rhs: rhs.toLayoutData())
}

@discardableResult public func |>|(lhs: LayoutDataConvertible, rhs: LayoutDataConvertible) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .greaterThanOrEqual, rhs: rhs.toLayoutData())
}

@discardableResult public func |<|(lhs: LayoutDataConvertible, rhs: LayoutDataConvertible) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .lessThanOrEqual, rhs: rhs.toLayoutData())
}

// MARK: - LayoutConstraint: [LayoutDataConvertible] |_| [LayoutDataConvertible]

@discardableResult public func |=|(lhs: [LayoutDataConvertible], rhs: [LayoutDataConvertible]) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.map { $0.toLayoutData() }, relation: .equal, rhs: rhs.map { $0.toLayoutData() })
}

@discardableResult public func |>|(lhs: [LayoutDataConvertible], rhs: [LayoutDataConvertible]) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.map { $0.toLayoutData() }, relation: .greaterThanOrEqual, rhs: rhs.map { $0.toLayoutData() })
}

@discardableResult public func |<|(lhs: [LayoutDataConvertible], rhs: [LayoutDataConvertible]) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.map { $0.toLayoutData() }, relation: .lessThanOrEqual, rhs: rhs.map { $0.toLayoutData() })
}

// MARK: - LayoutConstraint: [LayoutDataConvertible] |_| LayoutDataConvertible

@discardableResult public func |=|(lhs: [LayoutDataConvertible], rhs: LayoutDataConvertible) -> LayoutConstraint {
    return rhs |=| lhs
}

@discardableResult public func |=|(lhs: LayoutDataConvertible, rhs: [LayoutDataConvertible]) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .equal, rhs: rhs.map { $0.toLayoutData() } )
}

@discardableResult public func |<|(lhs: [LayoutDataConvertible], rhs: LayoutDataConvertible) -> LayoutConstraint {
    return rhs |>| lhs
}

@discardableResult public func |>|(lhs: LayoutDataConvertible, rhs: [LayoutDataConvertible]) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .greaterThanOrEqual, rhs: rhs.map { $0.toLayoutData() } )
}

@discardableResult public func |>|(lhs: [LayoutDataConvertible], rhs: LayoutDataConvertible) -> LayoutConstraint {
    return rhs |<| lhs
}

@discardableResult public func |<|(lhs: LayoutDataConvertible, rhs: [LayoutDataConvertible]) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .lessThanOrEqual, rhs: rhs.map { $0.toLayoutData() } )
}

// MARK: - LayoutConstraint: LayoutDataConvertible |_| (LayoutDataConvertible, LayoutDataConvertible)

@discardableResult public func |=|(lhs: LayoutDataConvertible, rhs: (LayoutDataConvertible, LayoutDataConvertible)) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .equal, rhs: layoutDataTuple(from: rhs))
}

@discardableResult public func |>|(lhs: LayoutDataConvertible, rhs: (LayoutDataConvertible, LayoutDataConvertible)) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .greaterThanOrEqual, rhs: layoutDataTuple(from: rhs))
}

@discardableResult public func |<|(lhs: LayoutDataConvertible, rhs: (LayoutDataConvertible, LayoutDataConvertible)) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.toLayoutData(), relation: .lessThanOrEqual, rhs: layoutDataTuple(from: rhs))
}

// MARK: - LayoutConstraint: [LayoutDataConvertible] |_| (LayoutDataConvertible, LayoutDataConvertible)

@discardableResult public func |=|(lhs: [LayoutDataConvertible], rhs: (LayoutDataConvertible, LayoutDataConvertible)) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.map { $0.toLayoutData() }, relation: .equal, rhs: layoutDataTuple(from: rhs))
}

@discardableResult public func |>|(lhs: [LayoutDataConvertible], rhs: (LayoutDataConvertible, LayoutDataConvertible)) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.map { $0.toLayoutData() }, relation: .greaterThanOrEqual, rhs: layoutDataTuple(from: rhs))
}

@discardableResult public func |<|(lhs: [LayoutDataConvertible], rhs: (LayoutDataConvertible, LayoutDataConvertible)) -> LayoutConstraint {
    return LayoutConstraint(lhs: lhs.map { $0.toLayoutData() }, relation: .lessThanOrEqual, rhs: layoutDataTuple(from: rhs))
}

// MARK: - Arithmetic

public func +(lhs: LayoutDataConvertible, rhs: CGFloat) -> LayoutData {
    return lhs.toLayoutData().with { $0.constant += rhs }
}

public func -(lhs: LayoutDataConvertible, rhs: CGFloat) -> LayoutData {
    return lhs.toLayoutData().with { $0.constant -= rhs }
}

public func *(lhs: LayoutDataConvertible, rhs: CGFloat) -> LayoutData {
    // Constant also needs to change for case like: (view.width - 16) / 2
    return lhs.toLayoutData().with { $0.multiplier *= rhs; $0.constant *= rhs }
}

public func /(lhs: LayoutDataConvertible, rhs: CGFloat) -> LayoutData {
    return lhs.toLayoutData().with { $0.multiplier /= rhs; $0.constant /= rhs }
}

// MARK: - Priority

precedencegroup LayoutPriorityPrecendence {
    higherThan: ComparisonPrecedence
    lowerThan:  NilCoalescingPrecedence
}

infix operator ! : LayoutPriorityPrecendence

public func !(lhs: LayoutDataConvertible, rhs: UILayoutPriority) -> LayoutData {
    return lhs.toLayoutData().with { $0.priority = rhs }
}

// MARK: - Tuple conversion

private func layoutDataTuple(from tuple: (LayoutDataConvertible, LayoutDataConvertible)) -> (LayoutData, LayoutData) {
    return (tuple.0.toLayoutData(), tuple.1.toLayoutData())
}
