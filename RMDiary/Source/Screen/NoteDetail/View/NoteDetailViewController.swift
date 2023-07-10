//
//  NoteDetailViewController.swift
//  RMDiary
//
//  Created by Renat Murtazin on 10.07.2023.
//

import UIKit

final class NoteDetailViewController: UIViewController {
  
  // MARK: - Private properties
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .bold)
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .regular)
    return label
  }()
  
  private lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .systemGray
    label.font = .systemFont(ofSize: 16, weight: .medium)
    return label
  }()
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(named: "viewBackgroundColor")
    
    setUpUI()
    setUpConstraints()
  }
  
  // MARK: - Initializers
  
  init(name: String, description: String, time: String) {
    super.init(nibName: nil, bundle: nil)
    
    self.nameLabel.text = name
    self.descriptionLabel.text = description
    self.timeLabel.text = time
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private functions

private extension NoteDetailViewController {
  
  func setUpUI() {
    
    view.addSubview(nameLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(timeLabel)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setUpConstraints() {
    
    nameLabel.snp.makeConstraints {
      $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp_bottomMargin).offset(16)
      $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    timeLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
      $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
  }
}
