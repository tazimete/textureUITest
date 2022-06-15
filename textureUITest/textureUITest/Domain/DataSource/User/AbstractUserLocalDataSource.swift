//
//  AbstractRepositoryLocalDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation


import RxSwift


/* This is user local data source abstraction extented from AbstractLocalDataSource. Which will be used to get user related data from repository database*/
protocol AbstractUserLocalDataSource: AbstractLocalDataSource {
    func search(accessToken: String, query: String, page: Int) -> Observable<[UserAPIRequest.ItemType]>
    func getUser(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType>
}
