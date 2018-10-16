//
//  ViewController.swift
//  MVC
//
//  Created by Jaba Odishelashvili on 10/15/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoListView: UIViewController {
    //MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    //MARK: Injections
    lazy var viewModel: PhotoListViewModel = PhotoListViewModel(service: APIService())
    
    //MARK: Object Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupView()
        viewModel.fetchData()
    }
    
    func setupViewModel() {
        viewModel.changeLoadingClosure = { [weak self] in
            let isLoading = self?.viewModel.isLoading ?? false
            if isLoading {
                self?.loadingView.startAnimating()
                self?.tableView.isHidden = true
            } else {
                self?.loadingView.stopAnimating()
                self?.tableView.isHidden = false
            }
        }
        
        viewModel.updateTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupView() {
        self.title = "Photoes"
        self.tableView.estimatedRowHeight = 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PhotoDetailView,
            let photoURL = sender as? String,
            segue.identifier == "PhotoDetailIdentifier" {
            
            dest.photoURL = photoURL
        }
    }
}

extension PhotoListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell  else {
            fatalError("Can't create PhotoTableViewCell")
        }
        
        let cellViewModel = viewModel.getItem(for: indexPath)
        cell.nameLabel.text = cellViewModel.name
        cell.createdAtLabel.text = cellViewModel.createdAt
        cell.descLabel.text = cellViewModel.desc
        cell.photoImageView.sd_setImage(with: URL(string: cellViewModel.imageURL), placeholderImage: nil, options: .lowPriority, completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.getItem(for: indexPath)
        self.performSegue(withIdentifier: "PhotoDetailIdentifier", sender: cellViewModel.imageURL)
    }
}
