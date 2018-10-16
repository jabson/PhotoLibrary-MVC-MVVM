//
//  PhotoDetailViewController.swift
//  MVC
//
//  Created by Jaba Odishelashvili on 10/16/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import UIKit

class PhotoDetailView: UIViewController {
    //MARK: Outlets
    @IBOutlet var imageView: UIImageView!
    
    //MARK: Injection
    var photoURL: String!
    
    //MARK: Object Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.sd_setImage(with: URL(string: photoURL), placeholderImage: nil, options: .lowPriority, completed: nil)
    }
}
