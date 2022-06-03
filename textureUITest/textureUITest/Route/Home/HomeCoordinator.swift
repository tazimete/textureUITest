//
//  HomeCoordinator.swift
//  currency-converter
//
//  Created by AGM Tazim on 3/26/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start(window: UIWindow) {
        let repository = CurrencyRepository(localDataSource: CurrencyLocalDataSource(dbClient: DatabaseClient.shared), remoteDataSource: CurrencyRemoteDataSource(apiClient: ApiClient.shared))
        
        let usecase = CurrencyUsecase(repository: repository)
        
        let commissionCalculator = ComissionCalculator(commissionOptions: ComissionDependency.shared, policies: [FirstFiveConversionComissionPolicy(commissionOptions: ComissionDependency.shared), EveryTenthComissionPolicy(commissionOptions: ComissionDependency.shared), UpToTwoHundredPolicy(commissionOptions: ComissionDependency.shared)])
        
        let balanceExecutor = BalanceOperationExecutor(operation: BalanceCheckOperation())
        
        let viewModel = MyBalanceViewModel(usecase: usecase, commissionCalculator: commissionCalculator, balanceExecutor: balanceExecutor)
        let vc = MyBalanceViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
