//
//  CustomCellCollectionViewCell.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 16.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

    class CustomCell: UICollectionViewCell {
        
        var data: PhotoContent? {
            
            didSet {
                imageCollection.image = data!.image
            }
        }
        
        private let imageCollection: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "image 18")
            image.clipsToBounds = true
            image.layer.cornerRadius = 6
            return image
            
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(imageCollection)
            
            let constraints = [
                
                imageCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                
            ]
            
            NSLayoutConstraint.activate(constraints)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
