//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by kosmokos I on 23.09.2022.
//
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    //MARK: Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var checkMarkButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var markImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkmark")
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Methods

    private func setupUI() {
        setupViews()
        setupConstraints()
        addTargets()
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(checkMarkButton)
        contentView.addSubview(markImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            counterLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            checkMarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            checkMarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkButton.heightAnchor.constraint(equalToConstant: 38),
            checkMarkButton.widthAnchor.constraint(equalToConstant: 38),
            
            markImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            markImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            markImage.heightAnchor.constraint(equalToConstant: 18),
            markImage.widthAnchor.constraint(equalToConstant: 18),
        ])

    }

    private func addTargets() {
        checkMarkButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(index: Int) {
        let index = titleLabel.tag
       
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
            markImage.alpha = 1
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            checkMarkButton.backgroundColor = titleLabel.textColor
            counterLabel.text = "Счетчик \(HabitsStore.shared.habits[index].trackDates.count)"
            
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        }
    }
    
    func updateCell(habit: Int) {

        titleLabel.tag = habit
        checkMarkButton.layer.borderColor = HabitsStore.shared.habits[habit].color.cgColor
        titleLabel.text = HabitsStore.shared.habits[habit].name
        titleLabel.textColor = HabitsStore.shared.habits[habit].color
        timeLabel.text = "Каждый день в \(HabitsStore.shared.habits[habit].dateString)"
        counterLabel.text = "Счетчик: \(HabitsStore.shared.habits[habit].trackDates.count)"
        
        if HabitsStore.shared.habits[habit].isAlreadyTakenToday {
            checkMarkButton.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[habit].color.cgColor)
            markImage.alpha = 1
        } else {
            checkMarkButton.backgroundColor = .clear
            markImage.alpha = 0
        }
    }

}
