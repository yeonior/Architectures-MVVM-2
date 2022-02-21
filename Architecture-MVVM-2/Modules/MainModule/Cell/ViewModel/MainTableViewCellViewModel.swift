//
//  MainTableViewCellViewModel.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 21.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import Foundation

protocol MainTableViewCellViewModelProtocol {
    var position: String { get }
    var image: Data? { get }
    var title: String { get }
    var isFavourite: Bool { get }
    init(photo: Photo)
}

final class MainTableViewCellViewModel: MainTableViewCellViewModelProtocol {
    private let photo: Photo!
    var position: String {
        String(photo.albumID) + "/" + String(photo.photoID)
    }
    var image: Data? {
        NetworkManager.shared.getData(from: photo.smallImageURL)
    }
    var title: String {
        photo.title
    }
    var isFavourite: Bool {
        DataManager.shared.getFavouriteStatus(for: photo.title)
    }
    
    init(photo: Photo) {
        self.photo = photo
    }
}
