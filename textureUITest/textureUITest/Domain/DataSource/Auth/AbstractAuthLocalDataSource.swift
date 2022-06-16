//
//  AbstractAuthLocalDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/13/22.
//

import Foundation
import RxSwift


/* This is AUth local data source abstraction extented from AbstractLocalDataSource. Which will be used to get user auth related data from user database*/
protocol AbstractAuthLocalDataSource: AbstractLocalDataSource {
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType>
}
