//
//  PhotoListViewModel.swift
//  MVC
//
//  Created by jaba odishelashvili on 10/16/18.
//  Copyright © 2018 Jaba Odishelashvili. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    var service: APIServiceProtocol
    
    private var photoTableViewCellViewModels = [PhotoTableViewCellViewModel]() {
        didSet {
            updateTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            changeLoadingClosure?()
        }
    }
    
    var itemCount: Int {
        get {
            return photoTableViewCellViewModels.count
        }
    }
    
    var changeLoadingClosure: (() -> ())?
    var updateTableViewClosure: (() -> ())?
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchData() {
        isLoading = true
        service.fetchPhotos { [weak self] (photos, error) in
            self?.isLoading = false
            self?.processFetchedPhotos(photos: photos)
        }
    }
    
    func processFetchedPhotos(photos: [Photo]?) {
        guard let photos = photos else { return }
        var cellViewModels = [PhotoTableViewCellViewModel]()
        
        for photo in photos {
            let cellViewModel = PhotoTableViewCellViewModel(name: photo.name,
                                                            desc: photo.desc,
                                                            createdAt: photo.createdAt,
                                                            imageURL: photo.imageURL)
            cellViewModels.append(cellViewModel)
        }
        self.photoTableViewCellViewModels = cellViewModels
    }
    
    func getItem(for indexPath: IndexPath) -> PhotoTableViewCellViewModel {
        return photoTableViewCellViewModels[indexPath.row]
    }
}
