//
//  GetImgursResponse.swift
//  lexer_imgur
//
//  Created by Alexey Il on 21.07.2021.
//

import Foundation

struct GetImgursResponse {
    let imgurs: [Imgur]
    
    init (json: JSON) throws {
        guard let dataJson = json["data"] as? [JSON] else { throw MyError.jsonError }
        let imgurs = dataJson.map{ Imgur(json: $0) }.compactMap{ $0 }
        self.imgurs = imgurs
    }
}

struct GetImgursCommentsResponse {
    let imgurComments: [ImgurComment]
    
    init (json: JSON) throws {
        guard let data = json["data"] as? [JSON] else {throw MyError.jsonError }
        let imgurComments = data.map{ ImgurComment(json: $0) }.compactMap{ $0 }
        self.imgurComments = imgurComments
    }
}
