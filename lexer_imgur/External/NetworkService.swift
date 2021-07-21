//
//  NetworkService.swift
//  lexer_imgur
//
//  Created by Alexey Il on 21.07.2021.
//

import Foundation
import UIKit

typealias JSON = [String: Any]

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    let session = URLSession.shared
    
    func getImgurs(success successBlock: @escaping (GetImgursResponse) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/search/top/?q=painting&q_size_px=small&q_type=jpg") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("Client-ID " + clientId, forHTTPHeaderField: "authorization")
        
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                let getImgursResponse = try GetImgursResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getImgursResponse)
                }
            } catch {}
        }.resume()
    }
    
    func downloadImage(fromLink link: String, success successBlock: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                  let image = UIImage(data: data)
                  else { return }
            DispatchQueue.main.async {
                successBlock(image)
            }
        }.resume()
    }
    
    func getImgursComments(_ itemId: String, success successBlock: @escaping (GetImgursCommentsResponse) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/\(itemId)/comments/best") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("Client-ID " + clientId, forHTTPHeaderField: "authorization")
        
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                let getImgursCommentsResponse = try GetImgursCommentsResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getImgursCommentsResponse)
                }
            } catch {}
        }.resume()
    }
}
