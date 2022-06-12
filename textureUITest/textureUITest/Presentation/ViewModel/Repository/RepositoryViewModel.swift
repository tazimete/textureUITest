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
    
    struct RepositoryInputModel {
        var accessToken: String
        var query: String
        var page: Int
    }
    
    // This struct will be used get event with data from viewcontroller
    struct RepositoryInput {
        let searchRepositoryTrigger: Observable<RepositoryInputModel>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    struct RepositoryOutput {
        let repositories: BehaviorRelay<[RepositoryAPIRequest.ItemType]?>
        let error: BehaviorRelay<NetworkError?>
    }
    
    let usecase: AbstractUsecase
    let disposeBag = DisposeBag()
    
    init(usecase: AbstractRepositoryUsecase) {
        self.usecase = usecase
    }
    
    func getRepositoryOutput(input: RepositoryInput) -> RepositoryOutput {
        let repositories = BehaviorRelay<[RepositoryAPIRequest.ItemType]?>(value: nil)
        let errorResponse = BehaviorRelay<NetworkError?>(value: nil)
        
        // get repository trigger
        input.searchRepositoryTrigger
            .flatMapLatest({ [weak self] (inputModel) -> Observable<RepositoryAPIRequest.ResponseType> in
                guard let weakSelf = self else {
                    return Observable.just(RepositoryAPIRequest.ResponseType())
                }
                
                //api call to get repository list 
                return weakSelf.searchRepository(accessToken: inputModel.accessToken, query: inputModel.query, page: inputModel.page)
                   .catch({ error in
                       errorResponse.accept(error as? NetworkError)
                       return Observable.just(RepositoryAPIRequest.ResponseType())
                    })
                })
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .subscribe(onNext: { response in
                repositories.accept(response.items)
            }, onError: { error in
                errorResponse.accept(error as? NetworkError)
            }).disposed(by: disposeBag)
        
        return RepositoryOutput.init(repositories: repositories, error: errorResponse)
    }
    
    // MARK: API CALLS
    func searchRepository(accessToken: String, query: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType> {
        (usecase as! AbstractRepositoryUsecase).search(accessToken: accessToken, query: query, page: page)
    }
}

