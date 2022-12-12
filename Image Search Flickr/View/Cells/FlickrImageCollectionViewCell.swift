//
//  FlickrImageCollectionViewCell.swift
//  Image Search Flickr
//
//  Created by Haresh Ghatala on 2022/12/12.
//

import UIKit

class FlickrImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        self.backgroundColor = .clear
        imageView.image = UIImage(systemName: "photo")
    }
    
    func setupBackgroundColor(index: Int) {
        switch (index % 4) {
            case 0, 3:
                self.backgroundColor = UIColor(named: "Flickr-Blue")!
            default:
                self.backgroundColor = UIColor(named: "Flickr-Pink")!
        }
    }
    
    func setupCellData(photoItem: PhotoItem, index: Int) {
        self.setupBackgroundColor(index: index)
        if let imgUrl = photoItem.generateImageURL() {
            self.imageView.load(urlStr: imgUrl)
        }
    }
    
}
