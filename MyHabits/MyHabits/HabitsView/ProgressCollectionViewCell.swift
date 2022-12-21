//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Кодочигов on 21.12.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell1"
    
    var progressLevel: Float? {
        
        didSet {
            
            progressView.progress = progressLevel ?? 0
            
        }
    }
    
    private lazy var motivationalText: UILabel = {
        let text = UILabel()
        text.text = "Everything is possible!"
        text.font = .systemFont(ofSize: 13, weight: .semibold)
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .myPurple
        progressView.progress = HabitsStore.shared.todayProgress
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    lazy var percentage: UILabel = {
        let percentage = UILabel()
        percentage.text = "\(Int(progressView.progress*100))%"
        percentage.font = .systemFont(ofSize: 13, weight: .semibold)
        percentage.textColor = .systemGray
        percentage.translatesAutoresizingMaskIntoConstraints = false
        return percentage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        contentView.addSubview(motivationalText)
        contentView.addSubview(progressView)
        contentView.addSubview(percentage)
        
        NSLayoutConstraint.activate([
            motivationalText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            motivationalText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            
            progressView.topAnchor.constraint(equalTo: motivationalText.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: motivationalText.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            
            percentage.topAnchor.constraint(equalTo: motivationalText.topAnchor),
            percentage.trailingAnchor.constraint(equalTo: progressView.trailingAnchor)
        ])
    }
}
