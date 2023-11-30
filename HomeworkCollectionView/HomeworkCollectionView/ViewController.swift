//
//  ViewController.swift
//  HomeworkCollectionView
//
//  Created by Иван Знак on 28/11/2023.
//

import UIKit
enum Section: Hashable, CaseIterable {
    case first
    case second
}

class ViewController: UIViewController, UICollectionViewDelegate {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionalLayout())
    
    let countOfCells = NumberOfCells(countOfTitles: 6, countOfChats: 10)
//    var titleItems : [TitleItem] = []
    var chatItems : [CellItem] = []
    var titleItems: [CellItem] = []
    var firstDataSource: UICollectionViewDiffableDataSource<Section, CellItem>!
//    var secondDataSource: UICollectionViewDiffableDataSource<Section, ChatItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillChatItems()
//        fillTitleItems()
        view.addSubview(collectionView)
        print("Start")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.id)
        collectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: ChatCollectionViewCell.id)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collectionView.delegate = self
        
        let firstCellRegistration = UICollectionView.CellRegistration<TitleCollectionViewCell, CellItem> {
            cell, indexPath, itemIdentifier in
            
            cell.label.text = itemIdentifier.title
        }
        let secondCellRegistration = UICollectionView.CellRegistration<ChatCollectionViewCell, CellItem> {
            cell, IndexPath, itemIdentifier in
            cell.titleLabel.text = itemIdentifier.title
            cell.subtitleLabel.text = itemIdentifier.subtitle
            cell.descriptionLabel.text = itemIdentifier.descriptionTitle
            cell.contactImageView.image = itemIdentifier.image
        }
        
        firstDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: CellItem) -> UICollectionViewCell? in
            if indexPath.section == 0 {
                let cell = collectionView.dequeueConfiguredReusableCell(using: firstCellRegistration, for: indexPath, item: itemIdentifier)
                return cell
            } else {
                let cell = collectionView.dequeueConfiguredReusableCell(using: secondCellRegistration, for: indexPath, item: itemIdentifier)
                return cell
            }
        }
        
//        secondDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: ChatItem) -> UICollectionViewCell? in
//            let cell = collectionView.dequeueConfiguredReusableCell(using: secondCellRegistration, for: indexPath, item: itemIdentifier)
//            return cell
//        }
        var firstSnapshot = NSDiffableDataSourceSnapshot<Section, CellItem>()
        firstSnapshot.appendSections([.first, .second])
        firstSnapshot.appendItems(chatItems, toSection: .first)
        firstSnapshot.appendItems(chatItems, toSection: .second)
        firstDataSource.apply(firstSnapshot, animatingDifferences: true)
        
//        var secondSnapshot = NSDiffableDataSourceSnapshot<Section, CellItem>()
//        secondSnapshot.appendSections([.second])
//        secondSnapshot.appendItems(chatItems, toSection: .second)
//        secondDataSource.apply(secondSnapshot, animatingDifferences: true)
    }
    
    func fillChatItems(){
        for i in 1...10 {
            chatItems.append(CellItem(title: "title\(i)", subtitle: "image\(i)", descriptionTitle: "full brand of \(i)", image: UIImage(named: "image\(i)") ?? UIImage()) )
        }
    }
    
//    func fillTitleItems(){
//        for i in 1...10 {
//            titleItems.append(TitleItem(title: "title\(i)"))
//        }
//    }
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, environment) ->
            NSCollectionLayoutSection? in
            if section == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/8))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .continuous
                return layoutSection
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let layoutSection = NSCollectionLayoutSection(group: group)
                
                return layoutSection
            }
        }
    }

    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        if indexPath.section == 1 {
    //            return CGSize(width: view.frame.width, height: (view.frame.height)/9)
    //        }
    //        else {
    //            return CGSize(width: 100, height: 40)
    //        }
    //    }

}

