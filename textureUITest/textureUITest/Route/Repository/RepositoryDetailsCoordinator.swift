//
//  RepositoryDetailsCoordinator.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/15/22.
//

import UIKit

class RepositoryDetailsCoordinator: Coordinator {
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
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}
