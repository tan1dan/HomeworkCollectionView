//
//  ChatCollectionViewCell.swift
//  HomeworkCollectionView
//
//  Created by Иван Знак on 28/11/2023.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    let contactImageView = UIImageView()
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let stackTitleView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let arrayOfLabels = [titleLabel, subtitleLabel, descriptionLabel]
        
        parametersForStackView()
        parametersForImageView()
        
        contentView.addSubview(contactImageView)
        contentView.addSubview(stackTitleView)
        
        NSLayoutConstraint.activate([
            contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor, multiplier: 1),
        ])
        
        func parametersForStackView(){
            stackTitleView.spacing = 5
            stackTitleView.translatesAutoresizingMaskIntoConstraints = false
            for i in 0...2 {
                arrayOfLabels[i].textAlignment = .left
                stackTitleView.addArrangedSubview(arrayOfLabels[i])
            }
            
        }
        func parametersForImageView(){
            contactImageView.translatesAutoresizingMaskIntoConstraints = false
            contactImageView.layer.cornerRadius = 0.5
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
