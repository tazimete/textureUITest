//
//  AbstractUserUsecase.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is user usecase abstraction extented from AbstractUsecase. Which will be used to get user related data from user repository*/
protocol AbstractUserUsecase: AbstractUsecase {
    func search(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType>
    func getUserDetails(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ResponseTypeDetails>
}
