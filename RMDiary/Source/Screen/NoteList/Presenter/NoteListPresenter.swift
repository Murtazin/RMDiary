//
//  NoteListPresenter.swift
//  RMDiary
//
//  Created by Renat Murtazin on 10.07.2023.
//

import Foundation

protocol INoteListOutput: AnyObject {
  func fetchNoteList(competion: (Result<[Note], Error>) -> Void)
}

final class NoteListPresenter {
  
  // MARK: - Private properties
  
  private let dataService: IDataService
  
  private weak var input: INoteListInput?
  
  // MARK: - Initializers
  
  init(dataService: IDataService) {
    self.dataService = dataService
  }
}

// MARK: - INoteListOutput

extension NoteListPresenter: INoteListOutput {
  
  func fetchNoteList(competion: (Result<[Note], Error>) -> Void) {
    dataService.fetchNoteList(competion: competion)
  }
}
