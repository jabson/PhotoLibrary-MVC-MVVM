//
//  ViewController.swift
//  MVC
//
//  Created by Jaba Odishelashvili on 10/15/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoListViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    //MARK: Injections
    var service: APIServiceProtocol = APIService()
    var photos = [Photo]()
    
    //MARK: Object Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
    }
    
    func setupView() {
        self.title = "Photoes"
        self.tableView.estimatedRowHeight = 150
        self.tableView.isHidden = true
        self.loadingView.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PhotoDetailViewController,
            let photo = sender as? Photo,
            segue.identifier == "PhotoDetailIdentifier" {
            
            dest.photo = photo
        }
    }
    
    //MARK: Data retrieve
    func fetchData() {
        service.fetchPhotos { [weak self] (photos, error) in
            if let photos = photos {
                self?.photos = photos
            }
            
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
            self?.loadingView.stopAnimating()
        }
    }
    
    //MARK: Data transformation
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

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell  else {
            fatalError("Can't create PhotoTableViewCell")
        }
        
        let photo = photos[indexPath.row]
        cell.nameLabel.text = photo.name
        cell.createdAtLabel.text = photo.createdAt
        cell.photoImageView.sd_setImage(with: URL(string: photo.imageURL), placeholderImage: nil, options: .lowPriority, completed: nil)
        if let formattedDate = getFormattedDate(dateString: photo.createdAt) {
            cell.createdAtLabel.text = formattedDate
        }
        if let description = photo.desc {
            cell.descLabel.text = description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        self.performSegue(withIdentifier: "PhotoDetailIdentifier", sender: photo)
    }
}
