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
    var animals: [String] = ["A", "B", "C", "D", "E", "F", "G", "H"]
    var repositoryViewModel: RepositoryViewModel!
    let inputSubject = PublishSubject<RepositoryViewModel.RepositoryInputModel>()
    
    // MAR: UI Objects
    lazy var tableNode: ASTableNode = {
        let tableNode = ASTableNode(style: .plain)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.reloadData()
        
        return tableNode
    }()
    
    // MARK: Constructors
    init(viewModel: AuthViewModel) {
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
        view.addSubnode(tableNode)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        tableNode.frame = view.frame
    }
    
    override func addActionsToSubviews() {

    }
    
    override func bindViewModel() {
        
    }
}


// MARK: - ASTableDelegate

extension RepositoryViewController: ASTableDelegate {
  func tableView(_ tableView: ASTableView, willBeginBatchFetchWith context: ASBatchContext) {
    nextPageWithCompletion { (results) in
      self.insertNewRows(results)
      context.completeBatchFetching(true)
    }
  }
  
  func shouldBatchFetch(for tableView: ASTableView) -> Bool {
    return true
  }
  
  func tableView(_ tableView: ASTableView, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
    return ASSizeRangeMake(CGSize(width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height/3) * 2), CGSize(width: UIScreen.main.bounds.size.width, height: .greatestFiniteMagnitude))
  }
}

// MARK: - ASTableDataSource

extension RepositoryViewController: ASTableDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return animals.count
  }
  
  func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    let animal = animals[(indexPath as NSIndexPath).row]
    
    return {
      let node = CardCellNode(animalInfo: animal)
      return node
    }
  }
}

// MARK: - Helpers

extension RepositoryViewController {
  func nextPageWithCompletion(_ block: @escaping (_ results: [String]) -> ()) {
    let moreAnimals = Array(self.animals[0 ..< 5])
    
    DispatchQueue.main.async {
      block(moreAnimals)
    }
  }
  
  func insertNewRows(_ newAnimals: [String]) {
    let section = 0
    var indexPaths = [IndexPath]()
    
    let newTotalNumberOfPhotos = animals.count + newAnimals.count
    
    for row in animals.count ..< newTotalNumberOfPhotos {
      let path = IndexPath(row: row, section: section)
      indexPaths.append(path)
    }
    
    animals.append(contentsOf: newAnimals)
    if let tableView = tableNode as? ASTableView {
      tableView.insertRows(at: indexPaths, with: .none)
    }
  }
}
