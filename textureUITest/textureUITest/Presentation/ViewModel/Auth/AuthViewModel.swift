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
    struct AuthInput {
        let authTrigger: Observable<URL>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    struct AuthOutput {
        let authResponse: BehaviorRelay<User?>
        let errorResponse: BehaviorRelay<NetworkError?>
    }
    
    let disposeBag = DisposeBag()
    let usecase: AbstractUsecase
    
    init(usecase: AbstractAuthUsecase) {
        self.usecase = usecase
    }
    
    func getAuthOutput(input: AuthInput) -> AuthOutput {
        let userResponse = BehaviorRelay<User?>(value: nil)
        let errorResponse = BehaviorRelay<NetworkError?>(value: nil)
        
        // get token trigger
        input.authTrigger
            .flatMapLatest({ [weak self] (authUrl) -> Observable<UserApiRequest.ItemType> in
                // check if  self is exists and balance is enough
                guard let weakSelf = self else {
                    return Observable.just(UserApiRequest.ItemType())
                }
                
                //convert currency with balance
                return weakSelf.getToken(url: authUrl)
                   .catch({ error in
                       errorResponse.accept(error as? NetworkError)
                       return Observable.just(UserApiRequest.ItemType())
                    })
                })
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .subscribe(onNext: { [weak self] response in
                let user = User(token: response.accessToken.unwrappedValue)
                
                self?.storeUserData(user: user)
                userResponse.accept(user)
            }, onError: { error in
                errorResponse.accept(error as? NetworkError)
            }).disposed(by: disposeBag)
        
        return AuthOutput.init(authResponse: userResponse, errorResponse: errorResponse)
    }
    
    func storeUserData(user: User) {
        UserSessionDataClient.shared.setAccessToken(token: user.token.unwrappedValue)
    }
    
    // MARK: API CALLS
    func getToken(url: URL) -> Observable<UserApiRequest.ItemType> {
        return (usecase as! AbstractAuthUsecase).getToken(url: url)
    }
}
