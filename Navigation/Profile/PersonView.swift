//
//  PersonView.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 24.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import iOSIntPackage

class PersonView: UIView {

   var named: String? {
        didSet {
            if let named = named,
               let img = UIImage(named: named) {
                let processor = ImageProcessor()
                processor.processImage(sourceImage: img, filter: .colorInvert) { (image) in
                    avatarImageView.image = image
                }
            }
        }
    }

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .darkGray
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
          }()

          override func draw(_ rect: CGRect) {
              addSubview(avatarImageView)

              self.avatarImageView.snp.makeConstraints { (make) -> Void in
                  make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
              }
          }
      }
