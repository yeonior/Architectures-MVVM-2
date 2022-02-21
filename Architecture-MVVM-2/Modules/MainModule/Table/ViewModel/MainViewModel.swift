//
//  MainViewModel.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
    var photos: [Photo]? { get }
    var viewModelDidChange: ((MainViewModelProtocol) -> ())? { get set }
    func fetchPhotos(completion: @escaping () -> ())
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> MainTableViewCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsViewModelProtocol
}

final class MainViewModel: MainViewModelProtocol {
    var photos: [Photo]? {
        didSet {
            viewModelDidChange?(self)
        }
    }
    var viewModelDidChange: ((MainViewModelProtocol) -> ())?
    
    func fetchPhotos(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            NetworkManager.shared.getPhotos { [weak self] result in
                switch result {
                case .success(let photos):
                    let slice = photos?.prefix(upTo: 10)
                    self?.photos = Array(slice!)
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                    completion()
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        photos?.count ?? 0
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MainTableViewCellViewModelProtocol {
        guard let photo = photos?[indexPath.row] else {
            let photo = Photo(albumID: 0, photoID: 0, title: "0", bigImageURL: "", smallImageURL: "")
            return MainTableViewCellViewModel(photo: photo)
        }
        
        return MainTableViewCellViewModel(photo: photo)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        guard let photo = photos?[indexPath.row] else {
            let photo = Photo(albumID: 0, photoID: 0, title: "0", bigImageURL: "", smallImageURL: "")
            return DetailsViewModel(photo: photo)
        }
        
        return DetailsViewModel(photo: photo)
    }
}
