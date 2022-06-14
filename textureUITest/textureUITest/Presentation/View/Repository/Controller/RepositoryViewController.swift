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
import RxDataSources_Texture

class RepositoryViewController: BaseViewController {
    weak var coordinator: RepositoryCoordinator?
    var repositoryList: [Repository] = [Repository]()
    var repositoryViewModel: RepositoryViewModel!
    let inputSubject = PublishSubject<RepositoryViewModel.RepositoryInputModel>()
    
    // MAR: UI Objects
    lazy var tableNode: ASTableNode = {
        let tableNode = ASTableNode(style: .plain)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.reloadData()
        tableNode.view.leadingScreensForBatching = 1.0;
        
        return tableNode
    }()
    
    var batchContext: ASBatchContext?
    
    // MARK: Constructors
    init(viewModel: RepositoryViewModel) {
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
        
        self.navigationItem.title = "Search Repository"
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
        repositoryViewModel = viewModel as! RepositoryViewModel
        let input = RepositoryViewModel.RepositoryInput(searchRepositoryTrigger: inputSubject)
        let output = repositoryViewModel.getRepositoryOutput(input: input)
        
        output.repositories
            .asDriver()
            .drive(onNext: { [weak self] data in
                guard let weakSelf = self, let data = data else {
                    return
                }

//                weakSelf.repositoryList.append(contentsOf: data)
                weakSelf.insertNewRows(data)
//                weakSelf.tableNode.reloadData()
            })
            .disposed(by: disposeBag)
        
        inputSubject.onNext(RepositoryViewModel.RepositoryInputModel(accessToken: UserSessionDataClient.shared.getAccessToken(), query: "test", page: 1))
        
        
        // RxDataSourceTexture
        let dataSource = RxASTableSectionedReloadDataSource<MainSection>(
            configureCellBlock: { (_, _, _, num) in
                return {
                    let cell = ASTextCellNode()
                    cell.text = "\(num)"
                    return cell
                }
        })
        
//        self.tableNode.rx
//              .setDelegate(self)
//              .disposed(by: disposeBag)
//
//        output.repositories
//              .do(onNext: { [weak self] _ in
//                self?.batchContext?.completeBatchFetching(true)
//              })
//              .bind(to: tableNode.rx.items(dataSource: dataSource))
//              .disposed(by: disposeBag)
//
//            self.tableNode.rx.willBeginBatchFetch
//              .asObservable()
//              .do(onNext: { [weak self] context in
//                self?.batchContext = context
//              }).map { _ in return Observable.just(RepositoryViewModel.RepositoryInputModel(accessToken: UserSessionDataClient.shared.getAccessToken(), query: "test", page: 1))}
//              .bind(to: input.searchRepositoryTrigger)
//              .disposed(by: disposeBag)
    }
}


// MARK: - ASTableDelegate

extension RepositoryViewController: ASTableDelegate {
  func tableView(_ tableView: ASTableView, willBeginBatchFetchWith context: ASBatchContext) {
    nextPageWithCompletion { (results) in
//      self.insertNewRows(results)
      context.completeBatchFetching(true)
    }
  }
  
  func shouldBatchFetch(for tableView: ASTableView) -> Bool {
    return true
  }
  
  func tableView(_ tableView: ASTableView, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
    return ASSizeRangeMake(CGSize(width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height/6)), CGSize(width: UIScreen.main.bounds.size.width, height: .greatestFiniteMagnitude))
  }
}

// MARK: - ASTableDataSource

extension RepositoryViewController: ASTableDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositoryList.count
  }

  func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    let item = repositoryList[(indexPath as NSIndexPath).row]

    return {
      let node = UserCellNode(item: item)
      return node
    }
  }
}

// MARK: - Helpers

extension RepositoryViewController {
  func nextPageWithCompletion(_ block: @escaping (_ results: [Repository]) -> ()) {
      inputSubject.onNext(RepositoryViewModel.RepositoryInputModel(accessToken: UserSessionDataClient.shared.getAccessToken(), query: "te", page: 2))
      
      DispatchQueue.main.async {
        block([])
      }
  }

  func insertNewRows(_ newAnimals: [Repository]) {
    let section = 0
    var indexPaths = [IndexPath]()

    let newTotalNumberOfPhotos = repositoryList.count + newAnimals.count

    for row in repositoryList.count ..< newTotalNumberOfPhotos {
      let path = IndexPath(row: row, section: section)
      indexPaths.append(path)
    }

      repositoryList.append(contentsOf: newAnimals)
      tableNode.insertRows(at: indexPaths, with: .none)
  }
    
    
}
