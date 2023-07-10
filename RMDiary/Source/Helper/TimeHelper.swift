//
//  TimeHelper.swift
//  RMDiary
//
//  Created by Renat Murtazin on 09.07.2023.
//

import Foundation

final class TimeHelper {
  
  // MARK: - Internal properties
  
  static let shared = TimeHelper()
  
  // MARK: - Initializers
  
  private init() { }
  
  // MARK: - Internal functions
  
  func formatToString(firstHour: Int, lastHour: Int) -> String {
    return String(format: "%02d:%02d", firstHour)
    + "-" + String(format: "%02d:%02d", lastHour)
  }
}
