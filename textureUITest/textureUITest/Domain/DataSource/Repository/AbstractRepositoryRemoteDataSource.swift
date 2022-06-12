//
//  AbstractRepositoryRemoteDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is repository remote data source abstraction extented from AbstractRemoteDataSource. Which will be used to get user repository related data from repository api*/
protocol AbstractRepositoryRemoteDataSource: AbstractRemoteDataSource {
    func search(accessToken: String, query: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType>
}
