//
//  RepositoryCoordinator.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit

class RepositoryCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let repository = CurrencyRepository(localDataSource: CurrencyLocalDataSource(dbClient: DatabaseClient.shared), remoteDataSource: CurrencyRemoteDataSource(apiClient: ApiClient.shared))
        
        let usecase = CurrencyUsecase(repository: repository)
        
        let viewModel = AuthViewModel(usecase: usecase)
        let vc = RepositoryViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [vc]
    }
}
