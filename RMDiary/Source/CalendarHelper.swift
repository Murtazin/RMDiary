//
//  CalendarHelper.swift
//  RMDiary
//
//  Created by Renat Murtazin on 07.07.2023.
//

import Foundation

final class CalendarHelper {
  
  // MARK: - Internal properties
  
  static let shared = CalendarHelper()
  
  // MARK: - Private properties
  
  private let calendar = Calendar.current
  
  // MARK: - Initializers
  
  private init() { }
  
  // MARK: - Internal functions
  
  func monthString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "LLLL"
    return dateFormatter.string(from: date)
  }
  
  func yearString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: date)
  }
  
  func dayOfMonth(date: Date) -> Int {
    let components = calendar.dateComponents([.day], from: date)
    guard let day = components.day else { return 0 }
    return day
  }
  
  func hourFromDate(date: Date) -> Int {
    let components = calendar.dateComponents([.hour], from: date)
    guard let hour = components.hour else { return 0 }
    return hour
  }
  
  func addDays(date: Date, days: Int) -> Date {
    guard let date = calendar.date(byAdding: .day, value: days, to: date) else { return Date() }
    return date
  }
  
  func sundayForDate(date: Date) -> Date {
    var current = date
    let oneWeekAgo = addDays(date: current, days: -7)
    
    while current > oneWeekAgo {
      let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
      if currentWeekDay == 1 {
        return current
      }
      current = addDays(date: current, days: -1)
    }
    return current
  }
  
  func isNoteDate(_ noteDate: Date, isSameDateAs date: Date, hour: Int) -> Bool {
    if calendar.isDate(noteDate, inSameDayAs: date) {
      let noteHour = CalendarHelper.shared.hourFromDate(date: noteDate)
      if noteHour == hour { return true }
    }
    return false
  }
}
