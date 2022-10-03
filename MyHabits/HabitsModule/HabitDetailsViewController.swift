//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by kosmokos I on 25.09.2022.
//
//

import UIKit

class HabitDetailsViewController: UIViewController {

    //MARK: Properties
    
    private let habitViewController: HabitViewController = {
        let view = HabitViewController()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: "HabitDetailsTableViewCell")
        view.backgroundColor = lightGray
        view.rowHeight = 44
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = lightGray
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if i == 1 {
            self.navigationController?.popViewController(animated: true)
            i = 0
        }
        
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: Methods

    private func setupUI() {
        setupNavBar()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNavBar() {

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = gray

        let editAction = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabbit))
        navigationItem.rightBarButtonItem = editAction
        editAction.tintColor = purple
    }

    @objc func editHabbit() {
        habitViewController.show = .edit
        
        let editNavigationController = UINavigationController(rootViewController: habitViewController)
        editNavigationController.modalPresentationStyle = .fullScreen
        present(editNavigationController, animated: true, completion: nil)
    }

}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitDetailsTableViewCell", for: indexPath) as! HabitDetailsTableViewCell
        let date = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        cell.dateLabel.text = date

        if HabitsStore.shared.habit(HabitsStore.shared.habits[habit], isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = purple
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }

}
