//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ivan Kamenev on 03.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let photos = [Photos(image: #imageLiteral(resourceName: "image 17")),
                  Photos(image: #imageLiteral(resourceName: "image 1")),
                  Photos(image: #imageLiteral(resourceName: "image 6")),
                  Photos(image: #imageLiteral(resourceName: "image 4")),
                  Photos(image: #imageLiteral(resourceName: "image 13")),
                  Photos(image: #imageLiteral(resourceName: "australian shepherd")),
                  Photos(image: #imageLiteral(resourceName: "image 12")),
                  Photos(image: #imageLiteral(resourceName: "image 3")),
                  Photos(image: #imageLiteral(resourceName: "image 20")),
                  Photos(image: #imageLiteral(resourceName: "jacksparrow")),
                  Photos(image: #imageLiteral(resourceName: "image 15")),
                  Photos(image: #imageLiteral(resourceName: "image 7")),
                  Photos(image: #imageLiteral(resourceName: "image 5")),
                  Photos(image: #imageLiteral(resourceName: "image 16")),
                  Photos(image: #imageLiteral(resourceName: "image 10")),
                  Photos(image: #imageLiteral(resourceName: "image 17")),
                  Photos(image: #imageLiteral(resourceName: "warrior")),
                  Photos(image: #imageLiteral(resourceName: "image 11")),
                  Photos(image: #imageLiteral(resourceName: "image 6")),
                  Photos(image: #imageLiteral(resourceName: "image 19")),
                  Photos(image: #imageLiteral(resourceName: "image 9"))
    ]
    
    private let cellSize = CGSize(width: 100, height: 100)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // default is .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        title = "Photo Gallery"
        
        view.addSubview(collectionView)
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PhotosCollectionViewCell
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    var inset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - inset * 4) / 3, height: (collectionView.frame.width - inset * 4) / 3)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return inset
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let photoCell = cell as? PhotosCollectionViewCell else { return }
        photoCell.photos = photos[indexPath.item]
    }
}
