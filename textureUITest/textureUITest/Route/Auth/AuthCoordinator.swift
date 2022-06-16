//
//  AuthCoordinator.swift
//  currency-converter
//
//  Created by AGM Tazim on 3/26/22.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let repository = AuthRepository(
                localDataSource: AuthLocalDataSource(dbClient: DatabaseClient.shared),
                remoteDataSource: AuthRemoteDataSource(apiClient: ApiClient.shared
            )
        )
        
        let usecase = AuthUsecase(repository: repository)
        let viewModel = AuthViewModel(usecase: usecase)
        let vc = AuthViewController(viewModel: viewModel)
        vc.coordinator = self 
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateRepositoryScreen(credential: UserCredential) {
        let repositoryCoordinator = SearchCoordinator(navigationController: navigationController)
        repositoryCoordinator.start()
    }
}
