//
//  AbstractRepositoryLocalDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation


import RxSwift


/* This is repository local data source abstraction extented from AbstractLocalDataSource. Which will be used to get user repository related data from repository database*/
protocol AbstractRepositoryLocalDataSource: AbstractLocalDataSource {
    func search(accessToken: String, page: Int) -> Observable<[RepositoryAPIRequest.ItemType]>
}
