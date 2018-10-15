//
//  PhotoDetailViewController.swift
//  MVC
//
//  Created by Jaba Odishelashvili on 10/16/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet var imageView: UIImageView!
    
    //MARK: Injection
    var photo: Photo!
    
    //MARK: Object Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = photo.name
        self.imageView.sd_setImage(with: URL(string: photo.imageURL), placeholderImage: nil, options: .lowPriority, completed: nil)
    }
}
