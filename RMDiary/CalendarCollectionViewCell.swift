//
//  CalendarCollectionViewCell.swift
//  RMDiary
//
//  Created by Renat Murtazin on 06.07.2023.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Internal properties
  
  static let reuseIdentifier = "CalendarCollectionViewCell"
  
  // MARK: - UI
  
  private lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .medium)
    return label
  }()
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpUI()
    setUpConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal functions
  
  func configure(text: String) {
    dayLabel.text = text
  }
}

// MARK: - Private functions

private extension CalendarCollectionViewCell {
  
  func setUpUI() {
    
    contentView.addSubview(dayLabel)
    
    dayLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setUpConstraints() {
    
    dayLabel.snp.makeConstraints {
      $0.centerX.equalTo(contentView)
      $0.centerY.equalTo(contentView)
    }
  }
}
