//
//  HomeCoordinator.swift
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
        let repository = CurrencyRepository(localDataSource: CurrencyLocalDataSource(dbClient: DatabaseClient.shared), remoteDataSource: CurrencyRemoteDataSource(apiClient: ApiClient.shared))
        
        let usecase = CurrencyUsecase(repository: repository)
        
        let commissionCalculator = ComissionCalculator(commissionOptions: ComissionDependency.shared, policies: [FirstFiveConversionComissionPolicy(commissionOptions: ComissionDependency.shared), EveryTenthComissionPolicy(commissionOptions: ComissionDependency.shared), UpToTwoHundredPolicy(commissionOptions: ComissionDependency.shared)])
        
        let balanceExecutor = BalanceOperationExecutor(operation: BalanceCheckOperation())
        
        let viewModel = MyBalanceViewModel(usecase: usecase, commissionCalculator: commissionCalculator, balanceExecutor: balanceExecutor)
        let vc = AuthViewController(viewModel: viewModel)
        vc.coordinator = self 
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateRepositoryScreen() {
        let repositoryCoordinator = RepositoryCoordinator(navigationController: navigationController)
        repositoryCoordinator.start()
    }
}
