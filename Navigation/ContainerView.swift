//
//  ContainerView.swift
//  Navigation
//
//  Created by Ivan Kamenev on 06.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ContainerView: UIStackView {
    
    var onTap: (() -> Void)?
    
    private lazy var upperButton: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var lowerButton: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(upperButton, lowerButton)
        
        let constraints = [
            upperButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            upperButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            upperButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            upperButton.heightAnchor.constraint(equalToConstant: 50),
            
            lowerButton.topAnchor.constraint(equalTo: upperButton.bottomAnchor, constant: 5),
            lowerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            lowerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            lowerButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func tapped() {
        onTap!()
    }
}
