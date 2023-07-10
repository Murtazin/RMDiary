//
//  NoteListModuleBuilder.swift
//  RMDiary
//
//  Created by Renat Murtazin on 10.07.2023.
//

import UIKit

final class NoteListModuleBuilder {
  
  // MARK: - Private properties
  
  private let dataService: IDataService
  
  // MARK: - Initializers
  
  init(dataService: IDataService) {
    self.dataService = dataService
  }
  
  // MARK: - Internal functions
  
  func build() -> UIViewController {
    let presenter = NoteListPresenter(dataService: dataService)
    let viewController = NoteListViewController(output: presenter)
    return viewController
  }
}
