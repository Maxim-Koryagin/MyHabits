//
//  HabitViewController.swift
//  MyHabits
//
//  Created by kosmokos I on 21.09.2022.
//

import UIKit

var habit = Int()
var i: Int = 0

class HabitViewController: UIViewController {

    //MARK: Properties
    
    enum HowToShow {
        case save
        case edit
    }
    
    var show: HowToShow = HowToShow.save
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6005590558, blue: 0.2179883718, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chooseTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var selectedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "11:00 PM"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.backgroundColor = .black
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку ?", preferredStyle: .alert)

    //MARK: LIfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = lightGray
        setupUI()
    }

    //MARK: Methods

    private func setupUI() {
        setupNavBar()
        setupViews()
        setupConstraints()
        addTargets()

        if show == .edit {

            titleTextField.text = HabitsStore.shared.habits[habit].name
            colorButton.backgroundColor = HabitsStore.shared.habits[habit].color
            selectedTimeLabel.text = HabitsStore.shared.habits[habit].dateString
            timePicker.date = HabitsStore.shared.habits[habit].date

            view.addSubview(deleteButton)

            NSLayoutConstraint.activate([

                deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18)
            ])

            alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
            }))
            alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
                HabitsStore.shared.habits.remove(at: habit)
                i = 1
                self.dismiss(animated: true)
            }))

        }
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(timeLabel)
        view.addSubview(chooseTimeLabel)
        view.addSubview(selectedTimeLabel)
        view.addSubview(timePicker)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            

            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            colorLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),

            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            chooseTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            chooseTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            selectedTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            selectedTimeLabel.leadingAnchor.constraint(equalTo: chooseTimeLabel.trailingAnchor, constant: 4),

            timePicker.topAnchor.constraint(equalTo: selectedTimeLabel.bottomAnchor, constant: 15),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }

    private func addTargets() {
        colorButton.addTarget(self, action: #selector(updateColor), for: .touchUpInside)

        timePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)

        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
    }

    @objc func updateColor() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }

    @objc func deleteHabit() {
        alertController.message = "Вы хотите удалить привычку \"\(titleTextField.text ?? "")\"?"
        self.present(alertController, animated: true, completion: nil)
    }

    private func setupNavBar() {

        if show == .save {
            navigationItem.title = "Создать"
        } else {
            navigationItem.title = "Править"
        }

        navigationController?.navigationBar.backgroundColor = gray

        navigationController?.navigationBar.tintColor = . black

        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let modalDismissAction = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(hideModal))
        navigationItem.leftBarButtonItems = [modalDismissAction]
        modalDismissAction.tintColor = purple

        let modalSaveAction = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabbit))
        navigationItem.rightBarButtonItem = modalSaveAction
        modalSaveAction.tintColor = purple
    }

    @objc func changeTime(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let convertedDate = dateFormatter.string(from: timePicker.date)
        selectedTimeLabel.text = convertedDate
    }

    @objc func hideModal(){
        dismiss(animated: true, completion: nil)
    }

    @objc func saveHabbit() {

        if show == .save {
            let newHabit = Habit(name: titleTextField.text ?? "",
                                 date: timePicker.date,
                                 color: colorButton.backgroundColor ?? .orange)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        } else {
            HabitsStore.shared.habits[habit].name = titleTextField.text ?? ""
            HabitsStore.shared.habits[habit].date = timePicker.date
            HabitsStore.shared.habits[habit].color = colorButton.backgroundColor ?? .orange
            HabitsStore.shared.save()
        }
        
        dismiss(animated: true, completion: nil)
    }

}

extension HabitViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.colorButton.backgroundColor = viewController.selectedColor
    }

}
