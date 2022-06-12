//
//  AbstractRepositoryUsecase.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is repository usecase abstraction extented from AbstractUsecase. Which will be used to get user repository related data from repository/github repository*/
protocol AbstractRepositoryUsecase: AbstractUsecase {
    func search(accessToken: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType>
}
