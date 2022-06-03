//
//  LocalStorage.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/7/22.
//

import Foundation

@propertyWrapper
struct KVLocalStorage<Value: Codable> {
//    typealias ValueKeyPath = ReferenceWritableKeyPath<EnclosingType, Value>
//    typealias SelfKeyPath = ReferenceWritableKeyPath<EnclosingType, Self>
    
    private let key: String
    private let defaultValue: Value

    init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    @available(*, unavailable, message: "@KVLocalStorage can only be applied to classes")
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    static subscript<EnclosingType: AbstractUserSessionDataClient>(
        _enclosingInstance instance: EnclosingType,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingType, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingType, Self>
    ) -> Value {
        get {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            let defaultValue = propertyWrapper.defaultValue
             //Read value from storage
            guard let data = instance.kvContainer.readKeyValuePair(id: key).value else {
                // Return defaultValue when no data in storgae
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? defaultValue
        }
        set {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            instance.kvContainer.createOrUpdateKeyValuePair(keyValuePair: KeyValuePair(key: key, value: data))
        }
    }
}
