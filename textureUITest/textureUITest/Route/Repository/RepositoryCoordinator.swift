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
        
        let commissionCalculator = ComissionCalculator(commissionOptions: ComissionDependency.shared, policies: [FirstFiveConversionComissionPolicy(commissionOptions: ComissionDependency.shared), EveryTenthComissionPolicy(commissionOptions: ComissionDependency.shared), UpToTwoHundredPolicy(commissionOptions: ComissionDependency.shared)])
        
        let balanceExecutor = BalanceOperationExecutor(operation: BalanceCheckOperation())
        
        let viewModel = MyBalanceViewModel(usecase: usecase, commissionCalculator: commissionCalculator, balanceExecutor: balanceExecutor)
        let vc = RepositoryViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [vc]
    }
}
