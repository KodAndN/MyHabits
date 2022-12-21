//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Кодочигов on 21.12.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    var habit: Habit? {

        didSet {

            habitNameLabel.text = habit?.name
            habitNameLabel.textColor = habit?.color
            statusCircle.layer.borderColor = habit?.color.cgColor
            timeDescriptionLabel.text = habit?.dateString
            counter.text = "Counter: \(habit?.trackDates.count ?? 0)"
            if ((habit?.isAlreadyTakenToday) == true) {
                statusCircle.image = .checkmark
                statusCircle.tintColor = habit?.color
                statusCircle.backgroundColor = habit?.color
            } else {
                statusCircle.image = .none
            }
        }
    }
    
    var delegate: HabitCollectionViewCellDelegate?
    
    private lazy var statusCircle: UIImageView = {
        let circle = UIImageView()
        circle.contentMode = .scaleToFill
        circle.clipsToBounds = true
        circle.layer.cornerRadius = 20
        circle.layer.borderWidth = 2
        let gesture = UITapGestureRecognizer(target: self, action: #selector(habitCompleted))
        circle.addGestureRecognizer(gesture)
        circle.isUserInteractionEnabled = true
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
        

    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drink a cup of water"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeDescriptionLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Every day at"
        nameLabel.textColor = .systemGray2
        nameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var counter: UILabel = {
        let counter = UILabel()
        counter.textColor = .systemGray
        counter.font = .systemFont(ofSize: 15, weight: .regular)
        counter.translatesAutoresizingMaskIntoConstraints = false
        return counter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConstraints()
    }

    @objc private func habitCompleted() {
        if(habit?.isAlreadyTakenToday == false) {
            
            HabitsStore.shared.track(habit!)
            delegate?.updateData()
            
        }
        
    }
    
    private func setConstraints() {
        contentView.addSubview(statusCircle)
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(timeDescriptionLabel)
        contentView.addSubview(counter)
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            
            timeDescriptionLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 7),
            timeDescriptionLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            
            counter.leadingAnchor.constraint(equalTo: timeDescriptionLabel.leadingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            statusCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusCircle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            statusCircle.heightAnchor.constraint(equalToConstant: 40),
            statusCircle.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

protocol HabitCollectionViewCellDelegate {
    
    func updateData()
    
}
