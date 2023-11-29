//
//  ViewController.swift
//  HomeworkCollectionView
//
//  Created by Иван Знак on 28/11/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let countOfCells = NumberOfCells(countOfTitles: 4, countOfChats: 10)
    var titleItems : [TitleItems] = []
    var chatItems : [CellItems] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return countOfCells.countOfTitles
        }
        else if section == 1 {
            return countOfCells.countOfChats
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as? TitleCollectionViewCell
            cell?.label.text = titleItems[indexPath.item].title
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            return cell ?? UICollectionViewCell()
            
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as? ChatCollectionViewCell
            cell?.contactImageView.image = chatItems[indexPath.item].image
            cell?.titleLabel.text = chatItems[indexPath.item].title
            cell?.subtitleLabel.text = chatItems[indexPath.item].subtitle
            cell?.descriptionLabel.text = chatItems[indexPath.item].descriptionTitle
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            return cell ?? UICollectionViewCell()
        }
        else {return UICollectionViewCell()}
    }
    
    func fillChatItems(){
        for i in 1...10 {
            chatItems.append(CellItems(title: "image\(i)", subtitle: "ok", descriptionTitle: "full brand of \(i)", image: UIImage(named: "image\(i)") ?? UIImage()) )
        }
    }
    
    func fillTitleItems(){
        for i in 1...10 {
            titleItems.append(TitleItems(title: "title\(i)"))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height)/9)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fillChatItems()
        fillTitleItems()
        view.addSubview(collectionView)
        print("Start")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "titleCell")
        collectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: "chatCell")
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}

