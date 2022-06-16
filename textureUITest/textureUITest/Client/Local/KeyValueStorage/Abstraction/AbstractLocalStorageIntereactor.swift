//
//  KVLocalSorageIntereactor.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/7/22.
//

import Foundation

/**
 This protocol will used as interactor to key value storage
 **/
protocol AbstractLocalKVStorageInteractor {
    func setData(keyValuePair: KeyValuePair)
    func getData(key: String) -> KeyValuePair
}

/**
 This protocol will used as interactor to local database 
 **/
protocol AbstractLocalDBStorageInteractor {
    static var shared: AbstractLocalStorageIntereactor {get}
    
    func create<T: Codable>(type: T.Type, item: T) -> Bool
    func createOrUpdate<T: Codable>(type: T.Type, item: T) -> Bool
    func createAll<T: Codable>(type: T.Type, items: [T]) -> Bool
    func read<T: Codable>(type: T.Type, id: String) -> T
    func readAll<T: Codable>(type: T.Type) -> [T]
    func update<T: Codable>(type: T.Type, item: T) -> Bool
    func updateAll<T: Codable>(type: T.Type, items: [T]) -> Bool
    func delete<T: Codable>(type: T.Type, item: T) -> Bool
    func deleteAll<T: Codable>(type: T.Type, items: [T]) -> Bool
    
    func createOrUpdateKeyValuePair(keyValuePair: KeyValuePair) -> Bool
    func readKeyValuePair(id: String) -> KeyValuePair
}

class KeyValuePair: Codable {
    let key: String
    let value: Data?
    
    init(key: String, value: Data?) {
        self.key = key
        self.value = value
    }
}

typealias AbstractLocalStorageIntereactor = AbstractLocalKVStorageInteractor & AbstractLocalDBStorageInteractor
