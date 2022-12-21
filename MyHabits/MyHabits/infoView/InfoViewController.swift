//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Андрей Кодочигов on 21.12.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(textView)
        setupConstraints()
    }
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "21 Day Habit \n \n The passage of the stages for which a habit is developed in 21 days is subject to the following algorithm: \n \n  1. Spend one day without reverting to old habits, try to act as if the goal is in perspective, to be within walking distance. \n \n 2. Maintain 2 days in the same state of self-control. \n \n 3. Mark in the diary the first week of changes and sum up the first results - what turned out to be difficult, what was easier, what still has to be seriously fought. \n \n 4. Congratulate yourself on passing your first major threshold at 21 days. During this time, the rejection of bad inclinations will already take the form of a conscious overcoming and a person will be able to work more towards the adoption of positive qualities. \n \n 5. Hold the plank for 40 days. The practitioner of the technique already feels freed from past negativity and is moving in the right direction with good dynamics. \n \n 6. On the 90th day of observing the technique, everything superfluous from the “past life” ceases to remind of itself, and a person, looking back, realizes himself completely renewed. \n \n Source: psychbook.ru"
        let attributtedString = NSMutableAttributedString(string: textView.text)
        attributtedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .semibold), range: NSRange(location: 0, length: 13))
        attributtedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .regular), range: NSRange(location: 13, length: 1117))
        
        textView.attributedText = attributtedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}
