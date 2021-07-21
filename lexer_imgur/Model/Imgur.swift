//
//  Imgur.swift
//  lexer_imgur
//
//  Created by Alexey Il on 21.07.2021.
//

import UIKit

struct Imgur {
    let id: String
    let link: String
    let title: String
    
    
    init?(json: JSON) {
        guard let id = json["id"] as? String,
              let title = json["title"] as? String,
              let link = json["cover"] as? String
            else { return nil }
        self.id = id
        self.link = "https://i.imgur.com/\(link).jpg"
        self.title = title
    }
    
    func image(completion: @escaping (UIImage) -> Void) {
        NetworkService.shared.downloadImage(fromLink: link) { (image) in
            completion(image)
        }
    }
}

struct ImgurComment {
    let author: String
    let comment: String
    
    init?(json: JSON) {
        guard let author = json["author"] as? String,
              let comment = json["comment"] as? String
        else { return nil }
        self.author = author
        self.comment = comment
    }
}
