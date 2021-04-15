//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 08.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var posts: PostContent? {
        didSet {
            contentImage.image = UIImage(named: posts!.image)
            authorLabel.text = posts?.author
            descriptionLabel.text = posts?.description
            viewsLabel.text = "Views: \(String(posts?.views ?? 0))"
            likesLabel.text = "Likes: \(String(posts?.likes ?? 0))"
            
        }
    }
    
    private let authorLabel: UILabel = {
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textLabel.numberOfLines = 2
        return textLabel
        
    }()
    
    private let descriptionLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .systemGray
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    private let viewsLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textLabel
    }()
    
    private let likesLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textLabel
    }()
    
    private let contentImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
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
        contentView.addSubviews(authorLabel, descriptionLabel, viewsLabel, likesLabel, contentImage)
        
        let constraints = [
            
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            contentImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            contentImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            contentImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

