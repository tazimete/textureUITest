//
//  Coordinator.swift
//  currency-converter
//
//  Created by AGM Tazimon 31/7/21.
//

import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    init(navigationController: UINavigationController)
    
    func start()
}


protocol Storyboarded {
    static func instantiate(viewModel: AbstractViewModel) -> Self
}

extension Storyboarded where Self: BaseViewController {
    static func instantiate(viewModel: AbstractViewModel) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        let viewController = storyboard.instantiateViewController(identifier: className) as! Self
        viewController.viewModel = viewModel
        
        return viewController
    }
}
