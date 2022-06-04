//
//  RepositoryViewController.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class RepositoryViewController: BaseViewController {
    
    // MARK: Constructors
    init(viewModel: MyBalanceViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Overrriden MethodS
    override func initView() {
        super.initView()
        //setup view
        view.backgroundColor = .white
        disableKeyboard(tappingView: view)
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        
        self.navigationItem.title = "Authentication"
    }
    
    override func addSubviews() {
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
    }
    
    override func addActionsToSubviews() {

    }
    
    override func bindViewModel() {
        
    }
}
