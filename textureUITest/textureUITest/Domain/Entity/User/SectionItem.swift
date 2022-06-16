//
//  SectionItem.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/13/22.
//

import RxDataSources_Texture

enum MainSection {
  case repo(repos: [MainSectionItem])
}

extension MainSection: AnimatableSectionModelType {

  typealias Identity = String

  var identity: String {
    switch self {
    case .repo: return "repo"
    }
  }

  var items: [MainSectionItem] {
    switch self {
    case .repo(let items): return items
    }
  }

  init(original: MainSection, items: [MainSectionItem]) {
    switch original {
    case .repo: self = .repo(repos: items)
    }
  }
}

enum MainSectionItem {
  case repo(UserData)
}

extension MainSectionItem: IdentifiableType {
  typealias Identity = Int

  var identity: Int {
    switch self {
    case .repo(let repo):
        return repo.id.unwrappedValue
    }
  }
}

extension MainSectionItem: Equatable {
  static func == (lhs: MainSectionItem, rhs: MainSectionItem) -> Bool {
    return lhs.identity == rhs.identity
  }
}
