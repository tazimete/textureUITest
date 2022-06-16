//
//  UserViewModel.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift
import RxCocoa

/* This is user viewmodel class implementation of AbstractUserViewModel. Which will be used to user data from its usecase*/
class UserViewModel: AbstractUserViewModel {
    
    struct UserSearchInputModel {
        var accessToken: String
        var query: String
        var page: Int
    }
    
    // This struct will be used get event with data from viewcontroller
    struct UserSearchInput {
        let searchUserTrigger: Observable<UserSearchInputModel>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    struct UserSearchOutput {
        let users: BehaviorRelay<[UserAPIRequest.ItemType]?>
        let error: BehaviorRelay<NetworkError?>
    }
    
    struct UserDetailsInputModel {
        var myAccessToken: String
        var name: String
        var id: Int
    }
    
    // This struct will be used get event with data from viewcontroller
    struct UserDetailsInput {
        let userDetailsTrigger: Observable<UserDetailsInputModel>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    struct UserDetailsOutput {
        let user: BehaviorRelay<UserAPIRequest.ItemType?>
        let error: BehaviorRelay<NetworkError?>
    }
    
    let usecase: AbstractUsecase
    let disposeBag = DisposeBag()
    var pageNo: Int = 1
    var totalDataCount: Int?
    
    init(usecase: AbstractUserUsecase) {
        self.usecase = usecase
    }
    
    func getUserSearchOutput(input: UserSearchInput) -> UserSearchOutput {
        let users = BehaviorRelay<[UserAPIRequest.ItemType]?>(value: nil)
        let errorResponse = BehaviorRelay<NetworkError?>(value: nil)
        
        // search user trigger
        input.searchUserTrigger
            .flatMapLatest({ [weak self] (inputModel) -> Observable<UserAPIRequest.ResponseType> in
                guard let weakSelf = self else {
                    return Observable.just(UserAPIRequest.ResponseType())
                }
                
                //api call to search user list
                return weakSelf.searchUsers(accessToken: inputModel.accessToken, query: inputModel.query, page: inputModel.page)
                   .catch({ error in
                       errorResponse.accept(error as? NetworkError)
                       return Observable.just(UserAPIRequest.ResponseType())
                    })
                })
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .subscribe(onNext: { [weak self] response in
                let values = (users.value ?? []) + (response.data ?? [])
                users.accept(values)
                self?.totalDataCount = response.totalCount
                self?.pageNo = self?.totalDataCount == nil ? 0 : (self?.pageNo).unwrappedValue+1 
            }, onError: { error in
                errorResponse.accept(error as? NetworkError)
            }).disposed(by: disposeBag)
        
        return UserSearchOutput.init(users: users, error: errorResponse)
    }
    
    func getUserDeatilsOutput(input: UserDetailsInput) -> UserDetailsOutput {
        let user = BehaviorRelay<UserAPIRequest.ItemType?>(value: nil)
        let errorResponse = BehaviorRelay<NetworkError?>(value: nil)
        
        // details user trigger
        input.userDetailsTrigger
            .flatMapLatest({ [weak self] (inputModel) -> Observable<UserAPIRequest.ResponseTypeDetails> in
                guard let weakSelf = self else {
                    return Observable.just(UserAPIRequest.ResponseTypeDetails())
                }
                
                //api call to search user list
                return weakSelf.getUserDetails(accessToken: inputModel.myAccessToken, name: inputModel.name, id: inputModel.id)
                   .catch({ error in
                       errorResponse.accept(error as? NetworkError)
                       return Observable.just(UserAPIRequest.ResponseTypeDetails())
                    })
                })
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .subscribe(onNext: { [weak self] response in
                user.accept(response.data)
            }, onError: { error in
                errorResponse.accept(error as? NetworkError)
            }).disposed(by: disposeBag)
        
        return UserDetailsOutput.init(user: user, error: errorResponse)
    }
    
    // MARK: API CALLS
    func searchUsers(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType> {
        (usecase as! AbstractUserUsecase).search(accessToken: accessToken, query: query, page: page)
    }
    
    func getUserDetails(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ResponseTypeDetails> {
        (usecase as! AbstractUserUsecase).getUserDetails(accessToken: accessToken, name: name, id: id)
    }
}

