//
//  APIService.swift
//  MVC
//
//  Created by Jaba Odishelashvili on 10/15/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPhotos(complate: @escaping ((_ photos: [Photo]?, _ error: Error?) -> ()))
}

class APIService: APIServiceProtocol {
    func fetchPhotos(complate: @escaping (([Photo]?, Error?) -> ())) {
        DispatchQueue.global().async {
            sleep(3)
            
            let path = Bundle.main.path(forResource: "content", ofType: "json")
            let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
            let decoder = JSONDecoder()
            let photos = try! decoder.decode(Photos.self, from: data)
            
            DispatchQueue.main.async {
                complate(photos.photos, nil)
            }
        }
    }
}
