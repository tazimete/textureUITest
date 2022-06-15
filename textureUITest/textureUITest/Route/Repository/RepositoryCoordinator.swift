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

    func start() {
        let repository = UserRepoRepository(
                localDataSource: RepositoryLocalDataSource(dbClient: DatabaseClient.shared),
                remoteDataSource: RepositoryRemoteDataSource(apiClient: ApiClient.shared
            )
        )
        
        let usecase = RepositoryUsecase(repository: repository)
        let viewModel = RepositoryViewModel(usecase: usecase)
        let vc = RepositoryViewController(viewModel: viewModel)
        vc.coordinator = self 
        self.navigationController.viewControllers = [vc]
    }
    
    func navigateToDetails() {
        let coordinator = RepositoryDetailsCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func backFromChild() {
        if childCoordinators.count > 0 {
            childCoordinators.removeLast()
        }
    }
}
