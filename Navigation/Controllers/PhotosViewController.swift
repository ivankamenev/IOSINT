//
//  PhotosViewController.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 16.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let photoCollectionImage: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionImage = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        collectionImage.register(CustomCell.self, forCellWithReuseIdentifier: String(describing: CustomCell.self))
        collectionImage.backgroundColor = .white
        
        return collectionImage
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Photo Gallery"
        photoCollectionImage.dataSource = self
        photoCollectionImage.delegate = self
        
        setupView()
        
    }
    
    func setupView() {
        
        view.addSubview(photoCollectionImage)
        
        let constraints = [
        
            photoCollectionImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            photoCollectionImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            photoCollectionImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            photoCollectionImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
  
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionImage.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCell.self), for: indexPath) as! CustomCell
        cell.data = photos[indexPath.row]
        return cell
    }
    
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: (collectionView.frame.width - 8 * 3) / 3 , height: (collectionView.frame.width - 8 * 3) / 3)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

