//
//  AbstractUserRemoteDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is user remote data source abstraction extented from AbstractRemoteDataSource. Which will be used to get user related data from repository api*/
protocol AbstractUserRemoteDataSource: AbstractRemoteDataSource {
    func search(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType>
    func getUser(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType>
}
