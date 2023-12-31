//
//  NotesListViewController.swift
//  RMDiary
//
//  Created by Renat Murtazin on 03.07.2023.
//

import SnapKit

protocol INoteListInput: AnyObject { }

final class NoteListViewController: UIViewController {
  
  // MARK: - Private properties
  
  private let output: INoteListOutput
  
  private var totalSquares = [Date]()
  private var selectedDate = Date()
  private var hours = [Int]()
  private var notes: [Note] = []
  
  // MARK: - UI
  
  private lazy var previousWeekButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "arrow-back-icon")
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var monthLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private lazy var nextWeekButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "arrow-ahead-icon")
    button.setImage(image, for: .normal)
    return button
  }()
  
  private lazy var daysOfWeekTitlesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalCentering
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
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
    setUpCurrentWeek()
    initializeHours()
    fetchNoteList()
  }
  
  // MARK: - Initializers
  
  init(output: INoteListOutput) {
    self.output = output
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private functions

private extension NoteListViewController {
  
  func setUpUI() {
    
    view.addSubview(previousWeekButton)
    view.addSubview(nextWeekButton)
    view.addSubview(monthLabel)
    view.addSubview(daysOfWeekTitlesStackView)
    view.addSubview(daysCollectionView)
    view.addSubview(notesTableView)
    
    previousWeekButton.translatesAutoresizingMaskIntoConstraints = false
    nextWeekButton.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    daysOfWeekTitlesStackView.translatesAutoresizingMaskIntoConstraints = false
    daysCollectionView.translatesAutoresizingMaskIntoConstraints = false
    notesTableView.translatesAutoresizingMaskIntoConstraints = false
    
    previousWeekButton.addTarget(self, action: #selector(previousWeekButtonDidTap), for: .touchUpInside)
    nextWeekButton.addTarget(self, action: #selector(nextWeekButtonDidTap), for: .touchUpInside)
    
    setUpDaysOfWeekTitlesStackView()
    setUpDaysCollectionView()
    setUpNotesTableView()
  }
  
  func setUpConstraints() {
    
    let buttonWidthHeightConstant: CGFloat = 30
    let collectionViewHeightConstant: CGFloat = 100
    
    previousWeekButton.snp.makeConstraints {
      $0.width.equalTo(buttonWidthHeightConstant)
      $0.height.equalTo(buttonWidthHeightConstant)
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
      $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    nextWeekButton.snp.makeConstraints {
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
    
    let daysOfWeekTitles = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    
    for title in daysOfWeekTitles {
      let label = UILabel()
      label.text = title
      label.textColor = .systemGray
      label.font = .systemFont(ofSize: 18, weight: .medium)
      daysOfWeekTitlesStackView.addArrangedSubview(label)
    }
  }
  
  func setUpDaysCollectionView() {
    
    daysCollectionView.dataSource = self
    daysCollectionView.delegate = self
    
    daysCollectionView.register(CalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
  }
  
  func setUpNotesTableView() {
    
    notesTableView.dataSource = self
    notesTableView.delegate = self
    
    notesTableView.register(NoteTableViewCell.self,
                            forCellReuseIdentifier: NoteTableViewCell.reuseIdentifier)
  }
  
  func setUpCurrentWeek() {
    
    totalSquares.removeAll()
    
    var current = CalendarHelper.shared.sundayForDate(date: selectedDate)
    let nextSunday = CalendarHelper.shared.addDays(date: current, days: 7)

    while current < nextSunday {
      totalSquares.append(current)
      current = CalendarHelper.shared.addDays(date: current, days: 1)
    }

    monthLabel.text = CalendarHelper.shared.monthString(date: selectedDate)
    + " " + CalendarHelper.shared.yearString(date: selectedDate)
    
    daysCollectionView.reloadData()
  }
  
  func initializeHours() {
    
    for hour in 0...23 {
      hours.append(hour)
    }
  }
  
  func fetchNoteList() {
    
    output.fetchNoteList { result in
      switch result {
      case .success(let notes):
        self.notes = notes
        print(notes)
      case .failure(let error):
        print(error)
      }
    }
  }
}

// MARK: - Objc functions

@objc private extension NoteListViewController {
  
  func previousWeekButtonDidTap(sender: UIButton) {
    
    selectedDate = CalendarHelper.shared.addDays(date: selectedDate, days: -7)
    setUpCurrentWeek()
  }
  
  func nextWeekButtonDidTap(sender: UIButton) {
    
    selectedDate = CalendarHelper.shared.addDays(date: selectedDate, days: 7)
    setUpCurrentWeek()
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension NoteListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return totalSquares.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
                                                        for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
    let date = totalSquares[indexPath.item]
    let text = String(CalendarHelper.shared.dayOfMonth(date: date))
    cell.backgroundColor = date == selectedDate ? .systemGreen : UIColor(named: "viewBackgroundColor")
    cell.configure(text: text)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    selectedDate = totalSquares[indexPath.item]
    collectionView.reloadData()
    notesTableView.reloadData()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NoteListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: collectionView.frame.width / 7, height: collectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return .zero
  }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NoteListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return hours.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier,
                                                   for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
    let hour = hours[indexPath.row]
    let lastHour = indexPath.row == hours.count - 1 ? 0 : hours[indexPath.row + 1]
    let note = NoteService.shared.getObjectFromListByDateAndTime(list: notes, date: selectedDate, time: hour)
    let time = TimeHelper.shared.formatIntToString(firstHour: hour, lastHour: lastHour)
    cell.configure(time: time, name: note?.name)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let hour = hours[indexPath.row]
    let lastHour = indexPath.row == hours.count - 1 ? 0 : hours[indexPath.row + 1]
    let time = TimeHelper.shared.formatIntToString(firstHour: hour, lastHour: lastHour)
    let note = NoteService.shared.getObjectFromListByDateAndTime(list: notes, date: selectedDate, time: hour)
    
    if let note = note {
      
      let name = note.name
      let description = note.description
      let detailVC = NoteDetailViewController(name: name, description: description, time: time)
      
      navigationController?.pushViewController(detailVC, animated: true)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
