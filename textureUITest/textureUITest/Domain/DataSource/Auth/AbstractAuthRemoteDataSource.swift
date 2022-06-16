//
//  AbstractAuthRemoteDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/13/22.
//

import Foundation
import RxSwift

/* This is Auth remote data source abstraction extented from AbstractRemoteDataSource. Which will be used to get user auth related data from auth api*/
protocol AbstractAuthRemoteDataSource: AbstractRemoteDataSource {
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType>
}
