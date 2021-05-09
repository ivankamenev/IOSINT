//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ivan Kamenev on 03.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "arrowshape.turn.up.right")
        imageView.tintColor = UIColor.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviews(photoLabel, arrowImageView, photosStackView)
        
        let imageOne = UIImageView(image: #imageLiteral(resourceName: "image 7"))
        imageOne.contentMode = .scaleToFill
        let imageTwo = UIImageView(image: #imageLiteral(resourceName: "image 20"))
        imageTwo.contentMode = .scaleToFill
        let imageThree = UIImageView(image: #imageLiteral(resourceName: "image 1"))
        imageThree.contentMode = .scaleToFill
        let imageFour = UIImageView(image: #imageLiteral(resourceName: "samurai"))
        imageFour.contentMode = .scaleToFill

        photosStackView.addArrangedSubview(imageOne)
        photosStackView.addArrangedSubview(imageTwo)
        photosStackView.addArrangedSubview(imageThree)
        photosStackView.addArrangedSubview(imageFour)

        
        let constraints = [
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            
            photosStackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photosStackView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
