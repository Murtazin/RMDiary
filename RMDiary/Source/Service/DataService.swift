//
//  DataService.swift
//  RMDiary
//
//  Created by Renat Murtazin on 09.07.2023.
//

import Foundation

protocol IDataService: AnyObject {
  func fetchNoteList(competion: (Result<[Note], Error>) -> Void)
}

final class DataService: IDataService {  
  
  // MARK: - Internal properties
  
  func fetchNoteList(competion: (Result<[Note], Error>) -> Void) {
    guard let path = Bundle.main.path(forResource: "notes", ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    do {
      let jsonData = try Data(contentsOf: url)
      let result = try JSONDecoder().decode([Note].self, from: jsonData)
      competion(.success(result))
    } catch {
      competion(.failure(error))
    }
  }
}
