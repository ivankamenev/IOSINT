//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Иван Каменев on 15.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

private enum State {
    case expanded
    case collapsed
    
    var change: State {
        switch self {
        case .expanded: return .collapsed
        case .collapsed: return .expanded
        }
    }
}

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private var initialFrame: CGRect?
    private var state: State = .collapsed
    
    private lazy var mainAnimator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    }()
    private lazy var closeButtonAnimator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar(recognizer:)))
        avatarImageView.addGestureRecognizer(tapAvatarGesture)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var statusText: String = ""
    let nameTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "My name"
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return textLabel
    }()
    
    let statusTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Waiting for something..."
        textLabel.textColor = .gray
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textLabel
    }()
    
    private lazy var avatarImageView: PersonView = {
        let personView = PersonView()
        personView.named = "avatar"
        personView.translatesAutoresizingMaskIntoConstraints = false
        return personView
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.roundCornersWithRadius(12, top: true, bottom: true, shadowEnabled: true)
        return button
    }()
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Write your status"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var blindView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.alpha = 0
        return view
    }()
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text ?? "Enter your status"
    }
    
    @objc func buttonPressed() {
        statusTextLabel.text = statusText
        print(statusText)
    }
    
    @objc private func didTapAvatar(recognizer: UITapGestureRecognizer) {
        print("1")
        expand()
        }
    
    @objc private func closeButtonTapped(_ sender: Any) {
        print("2")
        collapse()
    }
    
    func toggle() {
           switch state {
           case .expanded:
               collapse()
           case .collapsed:
               expand()
           }
       }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if state == .collapsed {
            avatarImageView.roundCornersWithRadius(avatarImageView.bounds.height/2, top: true, bottom: true, shadowEnabled: false)
        }
    }
       
       private func expand() {
        
        superview?.addSubviews(blindView,closeButton)
        
        let costraintsForAnimation = [
    
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),

            blindView.topAnchor.constraint(equalTo: superview!.topAnchor),
            blindView.leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            blindView.trailingAnchor.constraint(equalTo: superview!.trailingAnchor),
            blindView.bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            blindView.widthAnchor.constraint(equalTo: superview!.widthAnchor),
            blindView.heightAnchor.constraint(equalTo: superview!.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: superview!.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: superview!.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(costraintsForAnimation)
               
           
           mainAnimator.addAnimations {
            self.state = self.state.change
            let safeFrame: CGRect = self.superview!.safeAreaLayoutGuide.layoutFrame
            self.initialFrame = self.avatarImageView.frame
            let mainSize: CGFloat
            if safeFrame.width <= safeFrame.height {
                mainSize = safeFrame.width
            } else {
                mainSize = safeFrame.height
            }

            self.avatarImageView.frame = CGRect(x: CGFloat(safeFrame.width/2 - self.initialFrame!.width/2),
                                                    y: CGFloat(safeFrame.height/2 - self.initialFrame!.width/2+safeFrame.origin.y),
                                                    width: CGFloat(self.initialFrame!.width),
                                                    height: CGFloat(self.initialFrame!.height))
            self.avatarImageView.transform = self.avatarImageView.transform.scaledBy(x:mainSize/self.initialFrame!.width,
                                                            y:mainSize/self.initialFrame!.height)
            self.avatarImageView.layer.borderWidth = 3
            self.avatarImageView.layer.cornerRadius = 0
            self.blindView.alpha = 0.5
               
           }

           closeButtonAnimator.addAnimations {
                self.closeButton.alpha = 1
           }
           
           mainAnimator.addCompletion { position in
               switch position {
               case .end:
                    self.closeButtonAnimator.startAnimation()
               default:
                   ()
               }
           }
           
           mainAnimator.startAnimation()
       }
       
       private func collapse() {
        
        closeButtonAnimator.addAnimations {
                  self.closeButton.alpha = 0
              }
              
              mainAnimator.addAnimations {
                  self.state = self.state.change
                  
                  self.blindView.alpha = 0
                  self.avatarImageView.roundCornersWithRadius(self.initialFrame!.height/2, top: true, bottom: true, shadowEnabled: false)
                  
                  self.avatarImageView.transform = self.avatarImageView.transform.scaledBy(x:self.initialFrame!.width/self.avatarImageView.frame.width, y:self.initialFrame!.height/self.avatarImageView.frame.height)
                  
                  self.avatarImageView.frame = self.initialFrame!
                  
              }
              
              closeButtonAnimator.addCompletion { position in
                  switch position {
                  case .end:
                      self.mainAnimator.startAnimation()
                  default:
                      ()
                  }
              }
              closeButtonAnimator.startAnimation()
        
       }
    
    private func setupViews() {
        
        contentView.backgroundColor = .lightGray
        contentView.addSubviews(avatarImageView, nameTextLabel, statusTextLabel, statusButton, statusTextField)
        
        layoutMarginsDidChange()
        
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(statusButton.snp.top).offset(-16)
            make.height.width.equalTo(100)
        }
        
        nameTextLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        statusTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.top.equalTo(nameTextLabel.snp.bottom).offset(10)
            make.bottom.equalTo(statusButton.snp.top).offset(-54)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        statusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(contentView).offset(-16)
            make.leading.equalTo(contentView).offset(16)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.bottom.equalTo(statusButton.snp.top).offset(-10)
            make.height.equalTo(40)
        }
            
    }

}

extension UIView {
    
    /// Method adds shadow and corner radius for top of view by default.
    ///
    /// - Parameters:
    ///   - top: Top corners
    ///   - bottom: Bottom corners
    ///   - radius: Corner radius
    func roundCornersWithRadius(_ radius: CGFloat, top: Bool? = true, bottom: Bool? = true, shadowEnabled: Bool = true) {
        var maskedCorners = CACornerMask()
        
        if shadowEnabled {
            clipsToBounds = true
            layer.masksToBounds = false
            layer.shadowOpacity = 0.7
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 10
            layer.shadowOffset = CGSize(width: 4, height: 4)
        }
        
        switch (top, bottom) {
        case (true, false):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case (false, true):
            maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case (true, true):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        default:
            break
        }
        
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
    
}
