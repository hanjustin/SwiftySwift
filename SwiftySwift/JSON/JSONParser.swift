
/*
 Requirements:
 1. JSONParser will not be used to retrieve value of property with implicitly unwrapped optional type.
 2. For property with Enum cases, the Enum should conform to RawValueInitializable.
    Proper enum case will be instantiated if rawValue and value in JSON matches.
 3. Nested object should conform to JSONConvertible.
 */

import Foundation

public struct JSONParser {
    enum JSONParseError: Error {
        case noValueFound(key: String)
        case invalidEnumRawValue(key: String, rawValue: Any?)
        case invalidType(key: String, expected: Any.Type, actual: Any.Type)
        case unknownError(String)       // Client side logic error. Used to satisfy Xcode compile error.
    }
    
    private(set) var json: JSON
    
    public init(json: JSON) {
        self.json =  json
    }
    
    public func get(_ key: String) throws -> JSONParser {
        let newJson: JSON = try get(key)
        return JSONParser(json: newJson)
    }
    
    // Optional type parsing
    public func get<T: OptionalProtocol>(_ key: String) throws -> T {
        do {
            let wrapped: T.Wrapped = try get(key)
            return T.init(wrapped)
        } catch JSONParseError.noValueFound(let errorKey) where errorKey == key {
            // where clause needed because noValue error can be thrown from nestedObject's non-optional property
            return T.init(nil)
        } catch {
            throw error
        }
    }
    
    public func get<Element: JSONConvertible>(_ key: String) throws -> [Element]? {
        do {
            let elements: [Element] = try get(key)
            return elements
        } catch JSONParseError.noValueFound(let errorKey) where errorKey == key {
            return nil
        } catch {
            throw error
        }
    }
    
    public func get<Element: JSONDeserializable>(_ key: String) throws -> [Element] {
        let jsons: [JSON] = try get(key)
        return try jsons.map { try Element.init(json: $0) }
    }
    
    public func get<DeserializedDict: DictionaryProtocol>(_ key: String)
        throws -> DeserializedDict
        where DeserializedDict.Value: JSONDeserializable
    {
        let jsonDict: [DeserializedDict.Key : JSON] = try get(key)
        var deserializedDict = DeserializedDict()
        try jsonDict.forEach { key, json in deserializedDict[key] = try DeserializedDict.Value.init(json: json) }
        return deserializedDict
    }
    
    public func get<T>(_ key: String) throws -> T {
        if let value = json[key] as? T {
            return value
        } else if hasNilValueFor(key) {
            throw JSONParseError.noValueFound(key: key)
        } else if let rawValueConvertible = T.self as? RawValueInitializable.Type {
            return try initialize(type: rawValueConvertible, from: key)
        } else if let deserializableObject = T.self as? JSONDeserializable.Type {
            return try initialize(type: deserializableObject, from: key)
        } else {
            guard let value = json[key] else { throw JSONParseError.unknownError("No value found for key: \(key) when expecting non optional type") }
            throw JSONParseError.invalidType(key: key, expected: T.self, actual: type(of:value))
        }
    }
}


private extension JSONParser {
    func hasNilValueFor(_ key: String) -> Bool {
        let value = json[key]
        return value == nil || value is NSNull
    }
    
    func initialize<T>(type: RawValueInitializable.Type, from key: String) throws -> T {
        let rawValue = json[key]
        guard
            let parsedEnum = type.init(rawVal: rawValue) as? T
            else { throw JSONParseError.invalidEnumRawValue(key: key, rawValue: rawValue) }
        return parsedEnum
    }
    
    func initialize<T>(type: JSONDeserializable.Type, from key: String) throws -> T {
        guard
            let json = json[key] as? JSON,
            let deserializedJSON = try type.init(json: json) as? T
            else { throw JSONParseError.unknownError("Type T is not JSONDeserializable type") }
        return deserializedJSON
    }
}
