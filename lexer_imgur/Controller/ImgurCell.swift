//
//  ImgurCell.swift
//  lexer_imgur
//
//  Created by Alexey Il on 21.07.2021.
//

import UIKit

class ImgurCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with imgur: Imgur) {
        titleLabel.text = imgur.title
        
        imgur.image { (image) in
            self.imageView.image = image
        }
    }
    
    override func prepareForReuse() { // no clone picts
        titleLabel.text = nil
        imageView.image = nil
    }
}
