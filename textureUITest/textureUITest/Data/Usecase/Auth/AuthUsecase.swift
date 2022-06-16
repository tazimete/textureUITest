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
    
    func getToken(url: URL) -> Observable<UserApiRequest.ItemType> {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let code = (components?.queryItems?.first(where: { $0.name == "code" })?.value).unwrappedValue
        
        return (repository as! AbstractAuthRepository).getToken(authCode: code)
    }
}
