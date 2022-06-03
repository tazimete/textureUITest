//
//  KVLocalSorageIntereactor.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/7/22.
//

import Foundation


// MARK: KV Interactor 
extension UserDefaults: AbstractLocalKVStorageInteractor {
    func setData(keyValuePair: KeyValuePair) {
        self.set(keyValuePair.value, forKey: keyValuePair.key)
    }
    
    func getData(key: String) -> KeyValuePair {
         return KeyValuePair(key: key, value: self.data(forKey: key))
    }
}


// MARK: LOCAL DB Interactor
extension UserDefaults: AbstractLocalDBStorageInteractor {
    
    static var shared: AbstractLocalStorageIntereactor {
        return standard
    }
    
    func create<T: Codable>(type: T.Type, item: T) -> Bool {
        fatalError("Not Implemented Yet")
    }

    func createOrUpdate<T: Codable>(type: T.Type, item: T) -> Bool {
        fatalError("Not Implemented Yet")
    }
    
    func createAll<T: Codable>(type: T.Type, items: [T]) -> Bool {
        fatalError("Not Implemented Yet")
    }

    func read<T: Codable>(type: T.Type, id: String) -> T {
        fatalError("Not Implemented Yet")
    }

    func readAll<T: Codable>(type: T.Type) -> [T] {
        fatalError("Not Implemented Yet")
    }

    func update<T: Codable>(type: T.Type, item: T) -> Bool {
        fatalError("Not Implemented Yet")
    }

    func updateAll<T: Codable>(type: T.Type, items: [T]) -> Bool {
        fatalError("Not Implemented Yet")
    }

    func delete<T: Codable>(type: T.Type, item: T) -> Bool {
        fatalError("Not Implemented Yet")
    }

    func deleteAll<T: Codable>(type: T.Type, items: [T]) -> Bool {
        fatalError("Not Implemented Yet")
    }
    
    // MARK: Key Value Storage
    func createOrUpdateKeyValuePair(keyValuePair: KeyValuePair) -> Bool {
        self.setData(keyValuePair: keyValuePair)
        return true
    }
    
    func readKeyValuePair(id: String) -> KeyValuePair {
        return self.getData(key: id)
    }
}
