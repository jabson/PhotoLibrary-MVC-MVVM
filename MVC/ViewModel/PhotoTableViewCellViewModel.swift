//
//  PhotoTableViewCellViewModel.swift
//  MVC
//
//  Created by jaba odishelashvili on 10/16/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import Foundation

class PhotoTableViewCellViewModel {
    var name: String
    var desc: String = ""
    var createdAt: String = ""
    var imageURL: String
    
    init(name: String, desc: String?, createdAt: String, imageURL: String) {
        self.name = name
        self.desc = desc ?? ""
        self.imageURL = imageURL
        self.createdAt = getFormattedDate(dateString: createdAt) ?? ""
    }
    
    func getFormattedDate(dateString: String) -> String? {
        let fromFormatter = DateFormatter()
        fromFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let toFormatter = DateFormatter()
        toFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = fromFormatter.date(from: dateString) {
            return toFormatter.string(from: date)
        }
        
        return nil
    }
}
