//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 16.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let textLabelPhotos: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        text.text = "Photos"
        text.tintColor = .black
        return text
    }()
    
    private let imagePhotoView: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.clipsToBounds = true
        imagePhoto.layer.cornerRadius = 6
        imagePhoto.image = #imageLiteral(resourceName: "image 1")
        return imagePhoto
    }()
    private let imagePhotoView1: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.clipsToBounds = true
        imagePhoto.layer.cornerRadius = 6
        imagePhoto.image = #imageLiteral(resourceName: "image 8")
        return imagePhoto
    }()
    private let imagePhotoView2: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.clipsToBounds = true
        imagePhoto.layer.cornerRadius = 6
        imagePhoto.image = #imageLiteral(resourceName: "image 19")
        return imagePhoto
    }()
    private let imagePhotoView3: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.clipsToBounds = true
        imagePhoto.layer.cornerRadius = 6
        imagePhoto.image = #imageLiteral(resourceName: "image 20")
        return imagePhoto
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.forward")
        image.tintColor = .black
        return image
    }()
    
   
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        contentView.addSubviews(stackView, textLabelPhotos, arrowImage)
        stackView.addArrangedSubview(imagePhotoView)
        stackView.addArrangedSubview(imagePhotoView1)
        stackView.addArrangedSubview(imagePhotoView2)
        stackView.addArrangedSubview(imagePhotoView3)
        let constraints = [
            
            textLabelPhotos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            textLabelPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: textLabelPhotos.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            stackView.topAnchor.constraint(equalTo: textLabelPhotos.bottomAnchor, constant: 12),
            stackView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 12 * 2) / 4)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}






