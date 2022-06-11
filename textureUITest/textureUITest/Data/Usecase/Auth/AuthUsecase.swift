//
//  AuthUsecase.swift
//  currency-converter
//
//  Created by AGM Tazim on 14/05/22.
//

import Foundation
import RxSwift

/* This is auth usecase class implentation from AbstractAuthUsecase. Which will be used to get user auth related data from user repository*/
class AuthUsecase: AbstractAuthUsecase {
    let repository: AbstractRepository
    
    public init(repository: AbstractAuthRepository) {
        self.repository = repository
    }
    
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType> {
        return (repository as! AbstractAuthRepository).getToken(authCode: authCode)
    }
}
