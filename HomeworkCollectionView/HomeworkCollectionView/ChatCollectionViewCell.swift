//
//  ChatCollectionViewCell.swift
//  HomeworkCollectionView
//
//  Created by Иван Знак on 28/11/2023.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    static let id = "chatCell"
    let contactImageView = UIImageView()
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let stackTitleView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let arrayOfLabels = [titleLabel, subtitleLabel, descriptionLabel]
        
        contentView.addSubview(contactImageView)
        contentView.addSubview(stackTitleView)
        parametersForImageView()
        parametersForStackView()
        
        
        func parametersForStackView(){
            stackTitleView.spacing = 3
            stackTitleView.distribution = .fillEqually
            stackTitleView.axis = .vertical
            stackTitleView.translatesAutoresizingMaskIntoConstraints = false
            for i in 0...2 {
                arrayOfLabels[i].textAlignment = .left
//                arrayOfLabels[i].heightAnchor.constraint(equalToConstant: 10).isActive = true
                stackTitleView.addArrangedSubview(arrayOfLabels[i])
            }
            NSLayoutConstraint.activate([
                stackTitleView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 5),
                stackTitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                stackTitleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
                stackTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
        }
        
        func parametersForImageView(){
            contactImageView.translatesAutoresizingMaskIntoConstraints = false
            contactImageView.contentMode = .scaleAspectFill
            contactImageView.layer.cornerRadius = 50
            contactImageView.clipsToBounds = true
            NSLayoutConstraint.activate([
                contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
                contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor, multiplier: 1),
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
