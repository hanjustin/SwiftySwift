
import Foundation

public typealias JSON = [String : Any]
public typealias JSONConvertible = JSONSerializable & JSONDeserializable

public protocol JSONSerializable {
    func toJSON() -> JSON
    func customMapping(json: inout JSON)
}

extension JSONSerializable {
    public func customMapping(json: inout JSON) { }
}

public protocol JSONDeserializable {
    // Enum type property should have rawValue and conform to RawRepresentable
    init(json: JSON) throws
}

extension JSONSerializable {
    public func toJSON() -> JSON {
        var mirror: Mirror? = Mirror(reflecting: self)
        var json = JSON()
        
        while let currentMirror = mirror {
            for (propertyName, propertyValue) in currentMirror.children {
                if let propertyName = propertyName {
                    update(json: &json, with: (key: propertyName, value: propertyValue))
                }
            }
            
            mirror = currentMirror.superclassMirror
        }
        customMapping(json: &json)
        return json
    }
    
    private func update(json: inout JSON, with data: (key: String, value: Any)) {
        let key = data.key
        let value = convertToOptionalAnyFromMirrorAnyType(from: data.value)
        
        switch value {
        case let jsonObj as JSONSerializable:
            json[key] = jsonObj.toJSON()
            
        case let deserializedJSONs as [JSONSerializable]:
            json[key] = deserializedJSONs.map { $0.toJSON() }
            
        case let deserializedJSONDict as [AnyHashable : JSONSerializable]:
            var serializedDict = [AnyHashable : JSON]()
            deserializedJSONDict.forEach { key, jsonObject in
                serializedDict[key] = jsonObject.toJSON()
            }
            json[key] = serializedDict
            
        case let rawRepresentable as RawRepresentable:
            json[key] = rawRepresentable.typeErasedRawValue
            
        default:
            json[key] = value
        }
    }
    
    // Reference: http://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
    private func convertToOptionalAnyFromMirrorAnyType(from value: Any) -> Any? {
        // Mirror can return 'Any?' as 'Any'. So this is a conversion of 'Any' to 'Any?' if it is 'Any?'
        let mirror = Mirror(reflecting: value)
        guard (value is NSNull).isFalse else { return nil }
        guard let displayStyle = mirror.displayStyle, displayStyle == .optional else { return value }
        guard let unwrappedValue = mirror.children.first?.value, (unwrappedValue is NSNull).isFalse else { return nil }
        return unwrappedValue
    }
}

private extension RawRepresentable {
    var typeErasedRawValue: Any {
        return rawValue
    }
}

