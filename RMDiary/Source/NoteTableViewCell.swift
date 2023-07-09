//
//  NoteTableViewCell.swift
//  RMDiary
//
//  Created by Renat Murtazin on 09.07.2023.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
  
  // MARK: - Internal properties
  
  static let reuseIdentifier = "NoteTableViewCell"
  
  // MARK: - UI
  
  private lazy var timeLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  // MARK: - Initializers
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpUI()
    setUpConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal functions
  
  func configure(time: String, name: String?) {
    timeLabel.text = time
    nameLabel.text = name
  }
}

// MARK: - Private functions

private extension NoteTableViewCell {
  
  func setUpUI() {
    
    contentView.addSubview(timeLabel)
    contentView.addSubview(nameLabel)
    
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setUpConstraints() {
    
    timeLabel.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(contentView).inset(16)
    }
    
    nameLabel.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView).inset(16)
    }
  }
}
