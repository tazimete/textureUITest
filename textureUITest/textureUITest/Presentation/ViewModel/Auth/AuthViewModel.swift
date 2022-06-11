//
//  MyBalanceViewModel.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation
import RxSwift
import RxCocoa

/* This is my auth viewmodel class implementation of AbstractAuthViewModel. Which will be used to user related data by its usecase*/
class AuthViewModel: AbstractAuthViewModel {
    
    // This struct will be used get event with data from viewcontroller
    public struct AuthInput {
        let authTrigger: Observable<String>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    public struct AuthOutput {
        let user: BehaviorRelay<User?>
        let errorResponse: BehaviorRelay<NetworkError?>
    }
    
    let disposeBag =  DisposeBag()
    let usecase: AbstractUsecase
    
    
    public init(usecase: AbstractAuthUsecase) {
        self.usecase = usecase
    }
    
    public func getAuthOutput(input: AuthInput) -> AuthOutput {
        let userResponse = BehaviorRelay<User?>(value: nil)
        let errorResponse = BehaviorRelay<NetworkError?>(value: nil)
        
        // get token trigger
        input.authTrigger.flatMapLatest({ [weak self] (authCode) -> Observable<UserApiRequest.ItemType> in
            // check if  self is exists and balance is enough
            guard let weakSelf = self else {
                return Observable.just(UserApiRequest.ItemType())
            }
            
            //convert currency with balance
            return weakSelf.getToken(authCode: "")
                   .catch({ error in
                       errorResponse.accept(error as? NetworkError)
                       return Observable.just(UserApiRequest.ItemType())
                })
        })
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
        .subscribe(onNext: { response in
            userResponse.accept(User(id: response.id, token: response.token, name: response.email, email: response.email))
        }, onError: { [weak self] error in
            errorResponse.accept(error as? NetworkError)
        }).disposed(by: disposeBag)
        
        return AuthOutput.init(user: userResponse, errorResponse: errorResponse)
    }
    
    // MARK: API CALLS
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType> {
        return (usecase as! AbstractAuthUsecase).getToken(authCode: authCode)
    }
    
    
}
