//
//  AbstractRepositoryViewModel.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift
import RxRelay

/* This is AbstractMyBalanceViewModel abstraction extented from AbstractViewModel. Which will be used to get balance related data by its usecases*/
protocol AbstractRepositoryViewModel: AbstractViewModel {
    associatedtype RepositoryInput
    associatedtype RepositoryOutput
    
    var disposeBag: DisposeBag {get}
    
    // Transform the auth input to output observable
    func getRepositoryOutput(input: RepositoryInput) -> RepositoryOutput
    
    func searchRepository(accessToken: String, query: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType>
}
