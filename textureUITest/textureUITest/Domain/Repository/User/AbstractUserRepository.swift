//
//  AbstractUserRepository.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is user  repository abstraction extented from AbstractRepository. Which will be used to get user related data from api client/server response*/
protocol AbstractUserRepository: AbstractRepository {
    func searchRemote(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType>
    
    func searchLocal(accessToken: String, query: String, page: Int) -> Observable<[UserAPIRequest.ItemType]>
    
    func getUserRemote(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType>
    
    func getUserLocal(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType>
}
