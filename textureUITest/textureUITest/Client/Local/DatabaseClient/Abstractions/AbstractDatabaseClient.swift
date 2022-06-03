//
//  AbstractDatabaseClient.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/11/22.
//

import Foundation
import RxSwift

protocol DatabaseClientRepresentable {
    var interactor: AbstractLocalStorageIntereactor {get}
    var schedular: SchedulerType {get}
    
    init(interactor: AbstractLocalStorageIntereactor, schedular: SchedulerType)
}

protocol DataCreatable: DatabaseClientRepresentable {
    func create<T: Codable>(item: T, type: T.Type) -> Observable<Bool>
    func createAll<T: Codable>(items: [T], type: T.Type) -> Observable<Bool>
}

protocol DataReadable: DatabaseClientRepresentable {
    func read<T: Codable>(id: String, type: T.Type) -> Observable<T>
    func readAll<T: Codable>(type: T.Type) -> Observable<[T]>
}

protocol DataUpdatable: DatabaseClientRepresentable {
    func update<T: Codable>(item: T, type: T.Type) -> Observable<Bool>
    func updateAll<T: Codable>(items:[T], type: T.Type) -> Observable<Bool>
}

protocol DataDeletable: DatabaseClientRepresentable {
    func delete<T: Codable>(item: T, type: T.Type) -> Observable<Bool>
    func deleteAll<T: Codable>(items:[T], type: T.Type) -> Observable<Bool>
}


typealias AbstractDatabaseClient = DataCreatable & DataReadable & DataUpdatable & DataDeletable

