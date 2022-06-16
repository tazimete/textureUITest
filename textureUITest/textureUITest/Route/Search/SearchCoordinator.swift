//
//  RepositoryCoordinator.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let repository = UserRepository(
                localDataSource: UserLocalDataSource(dbClient: DatabaseClient.shared),
                remoteDataSource: UserRemoteDataSource(apiClient: ApiClient.shared
            )
        )
        
        let usecase = UserUsecase(repository: repository)
        let viewModel = UserViewModel(usecase: usecase)
        let vc = SearchViewController(viewModel: viewModel)
        vc.coordinator = self 
        self.navigationController.viewControllers = [vc]
    }
    
    func navigateToDetails() {
        let coordinator = UserDetailsCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func backFromChild() {
        if childCoordinators.count > 0 {
            childCoordinators.removeLast()
        }
    }
}
