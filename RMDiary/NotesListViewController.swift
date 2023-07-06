//
//  NotesListViewController.swift
//  RMDiary
//
//  Created by Renat Murtazin on 03.07.2023.
//

import SnapKit

final class NotesListViewController: UIViewController {
  
  // MARK: - UI
  
  private lazy var previousMonthButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "arrow-back-icon")
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var monthLabel: UILabel = {
    let label = UILabel()
    label.text = "Август 2023"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private lazy var nextMonthButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "arrow-ahead-icon")
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var daysOfWeekTitlesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = .init(top: 0, left: 4, bottom: 0, right: 4)
    return stackView
  }()
  
  private lazy var daysCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  private lazy var notesTableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  
  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(named: "viewBackgroundColor")
    
    setUpUI()
    setUpConstraints()
  }
}

// MARK: - Private functions

private extension NotesListViewController {
  
  func setUpUI() {
    
    view.addSubview(previousMonthButton)
    view.addSubview(nextMonthButton)
    view.addSubview(monthLabel)
    view.addSubview(daysOfWeekTitlesStackView)
    view.addSubview(daysCollectionView)
    view.addSubview(notesTableView)

    previousMonthButton.translatesAutoresizingMaskIntoConstraints = false
    nextMonthButton.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    daysOfWeekTitlesStackView.translatesAutoresizingMaskIntoConstraints = false
    daysCollectionView.translatesAutoresizingMaskIntoConstraints = false
    notesTableView.translatesAutoresizingMaskIntoConstraints = false
    
    setUpDaysOfWeekTitlesStackView()
  }
  
  func setUpConstraints() {
    
    let buttonWidthHeightConstant: CGFloat = 30
    let collectionViewHeightConstant: CGFloat = 100
    
    previousMonthButton.snp.makeConstraints {
      $0.width.equalTo(buttonWidthHeightConstant)
      $0.height.equalTo(buttonWidthHeightConstant)
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
      $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    nextMonthButton.snp.makeConstraints {
      $0.width.equalTo(buttonWidthHeightConstant)
      $0.height.equalTo(buttonWidthHeightConstant)
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
      $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    monthLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    daysOfWeekTitlesStackView.snp.makeConstraints {
      $0.width.equalTo(view.frame.width)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(monthLabel.snp_bottomMargin).offset(48)
    }
    
    daysCollectionView.snp.makeConstraints {
      $0.width.equalTo(view.frame.width)
      $0.height.equalTo(collectionViewHeightConstant)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(daysOfWeekTitlesStackView.snp_bottomMargin)
    }
    
    notesTableView.snp.makeConstraints {
      $0.top.equalTo(daysCollectionView.snp_bottomMargin)
      $0.leading.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.trailing.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func setUpDaysOfWeekTitlesStackView() {
    
    let daysOfWeekTitles = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    for title in daysOfWeekTitles {
      let label = UILabel()
      label.text = title
      label.textColor = .systemGray
      label.font = .systemFont(ofSize: 18, weight: .medium)
      daysOfWeekTitlesStackView.addArrangedSubview(label)
    }
  }
}

// MARK: - UICollectionViewDataSource

extension NotesListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NotesListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: collectionView.frame.width / 7, height: collectionView.frame.height)
  }
}
