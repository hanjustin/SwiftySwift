
import UIKit

public protocol LayoutDataConvertible {
    func toLayoutData() -> LayoutData
}

extension CGFloat: LayoutDataConvertible {
    public func toLayoutData() -> LayoutData { return LayoutData(constant: self) }
}

extension Int: LayoutDataConvertible {
    public func toLayoutData() -> LayoutData { return LayoutData(constant: CGFloat(self)) }
}

extension Double: LayoutDataConvertible {
    public func toLayoutData() -> LayoutData { return LayoutData(constant: CGFloat(self)) }
}

extension LayoutData: LayoutDataConvertible {
    public func toLayoutData() -> LayoutData { return self }
}

extension UIView: LayoutDataConvertible {
    public func toLayoutData() -> LayoutData { return LayoutData(item: self) }
}

// MARK: - LayoutData

public struct LayoutData: With {
    var item: AnyObject?
    var attributes: [NSLayoutAttribute]
    var multiplier: CGFloat
    var constant: CGFloat
    var priority: UILayoutPriority?
    
    init(item: AnyObject? = nil,
         attributes: [NSLayoutAttribute] = [.notAnAttribute],
         multiplier: CGFloat = 1,
         constant: CGFloat = 0,
         priority: UILayoutPriority? = nil)
    {
        self.item = item
        self.attributes = attributes
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
    }
    
    var flattenedData: [LayoutData] {
        return attributes.map { attribute in self.with { $0.attributes = [attribute] } }
    }
}

