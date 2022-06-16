//
//  AbstractAuthRepository.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation
import RxSwift

/* This is Auth repository abstraction extented from AbstractRepository. Which will be used to get user auth related data from api client/server response*/
protocol AbstractAuthRepository: AbstractRepository {
     func getToken(authCode: String) -> Observable<UserApiRequest.ItemType>
}
