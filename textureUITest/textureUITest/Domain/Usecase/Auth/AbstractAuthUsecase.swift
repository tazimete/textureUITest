//
//  AbstractAuthUsecase.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import Foundation
import RxSwift

/* This is Auth usecase abstraction extented from AbstractUsecase. Which will be used to get user auth related data from auth repository*/
protocol AbstractAuthUsecase: AbstractUsecase {
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType>
}
