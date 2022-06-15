//
//  AbstractUserViewModel.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift
import RxRelay

/* This is AbstractUserViewModel abstraction extented from AbstractViewModel. Which will be used to user data by its usecases*/
protocol AbstractUserViewModel: AbstractViewModel {
    associatedtype UserInput
    associatedtype UserOutput
    
    var disposeBag: DisposeBag {get}
    var pageNo: Int {get set}
    var totalDataCount: Int? {set get}
    
    // Transform the auth input to output observable
    func getUserOutput(input: UserInput) -> UserOutput
    
    func searchUsers(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType>
    func getUserDetails(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ResponseTypeDetails>
}
