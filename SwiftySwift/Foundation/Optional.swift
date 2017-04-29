
import Foundation

public protocol PossiblyEmpty {
    var nonEmptyValue: Self { get }
    var isEmpty: Bool { get }
}

extension Optional {
    public var isNil: Bool {
        switch self {
        case .none: return true
        case .some(_): return false
        }
    }
    
    public var isNotNil: Bool { return isNil.isFalse }
}

extension Optional {
    public func unwrap<T>(_ block: (Wrapped) throws -> T) rethrows -> T? {
        return try map(block)
    }
    
    public func flatUnwrap<T>(_ block: (Wrapped) throws -> T?) rethrows -> T? {
        return try flatMap(block)
    }
}
