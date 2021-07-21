//
//  ImgurCommentCell.swift
//  lexer_imgur
//
//  Created by Alexey Il on 21.07.2021.
//

import UIKit

class ImgurCommentCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    func configure(with imgurComment: ImgurComment) {
        authorLabel.text = imgurComment.author
        commentLabel.text = imgurComment.comment
        
        commentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        commentLabel.numberOfLines = 0
    }

}
