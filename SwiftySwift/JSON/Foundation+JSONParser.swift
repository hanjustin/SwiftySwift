
import Foundation

// MARK: - DictionaryProtocol

public protocol DictionaryProtocol {
    associatedtype Key: Hashable
    associatedtype Value
    
    init()
    
    subscript(key: Key) -> Value? { get set }
}

extension Dictionary: DictionaryProtocol { }

// MARK: - OptionalProtocol

public protocol OptionalProtocol {
    associatedtype Wrapped

    init(_ some: Wrapped)
    init(_ some: Wrapped?)
    
    var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
    public init(_ some: Wrapped?) {
        if let some = some {
            self = .some(some)
        } else {
            self = .none
        }
    }
}

extension ImplicitlyUnwrappedOptional: OptionalProtocol {
    public init(_ some: Wrapped?) {
        self = .none
    }
    
    public var isNil: Bool {
        switch self {
        case .none: return true
        case .some: return false
        }
    }
}
