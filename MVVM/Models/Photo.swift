//
//  File.swift
//  MVC
//
//  Created by Jaba Odishelashvili on 10/15/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import Foundation

struct Photos: Codable {
    var photos: [Photo]
}

struct Photo: Codable {
    let id: Int
    let name: String
    let desc: String?
    let createdAt: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case createdAt = "created_at"
        case imageURL = "image_url"
    }
}
