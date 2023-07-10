//
//  Note.swift
//  RMDiary
//
//  Created by Renat Murtazin on 08.07.2023.
//

import Foundation

final class NoteService {
  
  // MARK: - Internal properties
  
  static let shared = NoteService()
  
  // MARK: - Initializers
  
  private init() { }
  
  // MARK: - Internal functions
  
  func getObjectFromListByDateAndTime(list: [Note], date: Date, time: Int) -> Note? {
    for note in list {
      let isSameDate = CalendarHelper.shared.isNoteDate(note.startDate, isSameDateAs: date, hour: time)
      if isSameDate { return note }
    }
    return nil
  }
}

struct Note: Codable {
  
  // MARK: - Internal propties
  
  let id: Int
  let startDate: Date
  let finishDate: Date
  let name: String
  let description: String
  
  // MARK: - Private enums
  
  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case startDate = "date_start"
    case finishDate = "date_finish"
    case name = "name"
    case description = "description"
  }
}
