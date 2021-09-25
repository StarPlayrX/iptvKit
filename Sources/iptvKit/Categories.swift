//
//  Categories.swift
//  
//
//  Created by M1 on 9/24/21.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let categoryID, categoryName: String
    let parentID: Int
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case parentID = "parent_id"
    }
}

typealias Categories = [Category]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


//MARK: Text
internal func CategoriesAsync(endpoint: String, TextHandler: @escaping TextHandler)  {

    guard let url = URL(string: endpoint) else {TextHandler("error1"); return}
    
    var urlReq = URLRequest(url: url)
    urlReq.httpMethod = "GET"
    urlReq.timeoutInterval = TimeInterval(30)
    urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
        guard
            let d = data,
            let text = String(data: d, encoding: .utf8)
        else { TextHandler("error2"); return }
        
        print(text)
        TextHandler(text)
    }
    
    task.resume()
}
