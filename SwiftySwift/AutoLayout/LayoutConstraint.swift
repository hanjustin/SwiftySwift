
import UIKit

public struct LayoutConstraint {
    private(set) var constraints = [NSLayoutConstraint]()
    
    private init() { }
    
    init(lhs: LayoutData, relation: NSLayoutRelation, rhs: LayoutData) {
        let (lhs, relation, rhs) = formattedConstraintData(lhs: lhs, relation: relation, rhs: rhs)
        guard let lhsItem = lhs.item else { fatalError("lhs data item required for NSLayoutConstraint constructor.") }
        
        for i in 0 ..< lhs.attributes.count {
            let lhsAttribute = lhs.attributes[i]
            let rhsItem = rhs.item
            let rhsAttribute = rhs.attributes[i]
            let constraint = NSLayoutConstraint(item: lhsItem,
                                                attribute: lhsAttribute,
                                                relatedBy: relation,
                                                toItem: rhsItem,
                                                attribute: rhsAttribute,
                                                multiplier: rhs.multiplier / lhs.multiplier,
                                                constant: rhs.constant - lhs.constant)
            constraint.priority = lhs.priority ?? rhs.priority ?? UILayoutPriorityRequired
            constraint.isActive = true
            constraints.append(constraint)
        }
    }
    
    // MARK: - Array
    
    init(lhs: LayoutData, relation: NSLayoutRelation, rhs: [LayoutData]) {
        constraints = rhs.map { LayoutConstraint(lhs: lhs, relation: relation, rhs: $0) }.flatMap { $0.constraints }
    }
    
    init(lhs: [LayoutData], relation: NSLayoutRelation, rhs: [LayoutData]) {
        guard lhs.count == rhs.count else {
            fatalError("lhs & rhs array size mismatch. \n lhs: \(lhs) count: \(lhs.count) \n rhs: \(rhs) count: \(rhs.count)")
        }
        
        constraints = zip(lhs, rhs).flatMap { LayoutConstraint(lhs: $0, relation: relation, rhs: $1).constraints }
    }
    
    // MARK: - Tuple
    
    init(lhs: LayoutData, relation: NSLayoutRelation, rhs: (LayoutData, LayoutData)) {
        constraints = LayoutConstraint(lhs: lhs.flattenedData, relation: relation, rhs: [rhs.0, rhs.1]).constraints
    }
    
    init(lhs: [LayoutData], relation: NSLayoutRelation, rhs: (LayoutData, LayoutData)) {
        constraints = lhs.flatMap { LayoutConstraint(lhs: $0, relation: relation, rhs: rhs).constraints }
    }
}

private extension LayoutConstraint {
    func formattedConstraintData(
        lhs: LayoutData,
        relation: NSLayoutRelation,
        rhs: LayoutData)
        -> (lhs: LayoutData, relation: NSLayoutRelation, rhs: LayoutData)
    {
        var lhs = lhs, rhs = rhs
        let needToSwap = lhs.item == nil
        if needToSwap { swap(&lhs, &rhs) } // NSLayoutConstraint constructor requires an item in first argument
        
        copyAttributeIfNeeded(from: lhs, to: &rhs)
        copyAttributeIfNeeded(from: rhs, to: &lhs)
        
        validateNumberOfAttributesFor(lhs: lhs, rhs: rhs)
        return (lhs, relation, rhs)
    }
    
    func validateNumberOfAttributesFor(lhs: LayoutData, rhs: LayoutData) {
        let hasValidAttributesCount = lhs.item != nil && (rhs.item == nil || lhs.attributes.count == rhs.attributes.count)
        guard hasValidAttributesCount else {
            fatalError("lhs & rhs attribute size mismatch. \n lhs: \(lhs.attributes) count: \(lhs.attributes.count) \n rhs: \(rhs.attributes) count: \(rhs.attributes.count)")
        }
    }
    
    func copyAttributeIfNeeded(from source: LayoutData, to target: inout LayoutData) {
        // i.e. True: view1.top |=| view2, False: view1.width |=| 100
        let needAttributeInheritance = (target.item != nil && target.attributes == [.notAnAttribute])
        guard needAttributeInheritance else { return }
        target.attributes = attributeToCopy(from: source)
    }
    
    func attributeToCopy(from source: LayoutData) -> [NSLayoutAttribute] {
        if source.item is UILayoutSupport {
            return source.attributes[0] == .bottom ? [.top] : [.bottom]    // Infer .top for view1 |=| topLayoutGuideBottom
        } else {
            return source.attributes
        }
    }
}
