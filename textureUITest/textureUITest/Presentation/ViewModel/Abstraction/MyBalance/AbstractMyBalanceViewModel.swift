//
//  AbstractMyBalanceViewModel.swift
//  currency-converter
//
//  Created by AGM Tazim on 31/10/21.
//


import Foundation
import RxSwift
import RxRelay

/* This is AbstractMyBalanceViewModel abstraction extented from AbstractViewModel. Which will be used to get balance related data by its usecases*/
protocol AbstractAuthViewModel: AbstractViewModel {
    associatedtype AuthInput
    associatedtype AuthOutput
    
    var disposeBag: DisposeBag {get}
    
    // Transform the auth input to output observable
    func getAuthOutput(input: AuthInput) -> AuthOutput
}


