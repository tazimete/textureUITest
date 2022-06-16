//
//  RepositoryDetailsCoordinator.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/15/22.
//

import UIKit

class UserDetailsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var user: UserData!

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
        let vc = UserDetailsViewController(viewModel: viewModel)
        vc.user = user 
        vc.coordinator = self
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}
