//
//  RepositoryViewModel.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift
import RxCocoa

/* This is user repository viewmodel class implementation of AbstractRepositoryViewModel. Which will be used to user repo data from its usecase*/
class RepositoryViewModel: AbstractRepositoryViewModel {
    
    // This struct will be used get event with data from viewcontroller
    public struct RepositoryInput {
        let fetchRepositoryTrigger: Observable<Int>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    public struct RepositoryOutput {
        let repositories: BehaviorRelay<[RepositoryAPIRequest.ItemType]?>
        let error: BehaviorRelay<NetworkError?>
    }
    
    let usecase: AbstractUsecase
    let disposeBag = DisposeBag()
    
    public init(usecase: AbstractRepositoryUsecase) {
        self.usecase = usecase
    }
    
    public func getAuthOutput(input: RepositoryInput) -> RepositoryOutput {
        let repositories = BehaviorRelay<[RepositoryAPIRequest.ItemType]?>(value: nil)
        let error = BehaviorRelay<NetworkError?>(value: nil)
        
        // get repository trigger
        input.fetchRepositoryTrigger
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
            .subscribe(onNext: { response in
                let user = User(token: response.tokenType.unwrappedValue + " " + response.accessToken.unwrappedValue)
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

