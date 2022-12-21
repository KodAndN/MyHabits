//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Андрей Кодочигов on 21.12.2022.
//

import UIKit

class HabitsViewController: UIViewController, UICollectionViewDelegate, HabitCollectionViewCellDelegate {
  
        private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.headerReferenceSize = CGSize(width: 0, height: 20)
            layout.footerReferenceSize = CGSize(width: 0, height: 5)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
            collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
            collectionView.backgroundColor = .myWhite
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Today"
        navigationController?.navigationBar.prefersLargeTitles = true
        updateData()
    }
    
    func bluer() {
        
        let bluer = UIBlurEffect(style: .light)
        let bluerEffect = UIVisualEffectView(effect: bluer)
        bluerEffect.frame = (tabBarController?.tabBar.bounds)!

    }
    
    private func settings() {
        self.view.backgroundColor = .myWhite
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem?.tintColor = .myPurple
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .white

        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = compactAppearance
    }
    
    func updateData() {
        collectionView.reloadData()
    }
    
    @objc func addButton() {
        let habitVC = HabitViewController()
        let navVC = UINavigationController(rootViewController: habitVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func setConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension HabitsViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let neededWidth = collectionView.frame.width - 30
            let itemWidth = floor(neededWidth)
            return CGSize(width: itemWidth, height: 60)
        } else {
            let neededWidth = collectionView.frame.width - 30
            let itemWidth = floor(neededWidth)
            return CGSize(width: itemWidth, height: 140)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            cell.progressLevel = HabitsStore.shared.todayProgress
            cell.percentage.text = "\(Int((cell.progressLevel ?? 0) * 100))%"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
            
            cell.habit = HabitsStore.shared.habits[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            
            let habitDetailsView = HabitDetailsViewController()
            habitDetailsView.habit = HabitsStore.shared.habits[indexPath.row]
            habitDetailsView.title = HabitsStore.shared.habits[indexPath.row].name
            navigationController?.pushViewController(habitDetailsView, animated: true)
            
        }
    }
}

