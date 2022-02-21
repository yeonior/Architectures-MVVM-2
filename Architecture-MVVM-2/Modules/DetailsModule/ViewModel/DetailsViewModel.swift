//
//  DetailsViewModel.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//

import Foundation
import UIKit

protocol DetailsViewModelProtocol {
    var title: String { get }
    var position: String { get }
    var image: Data? { get }
    var isFavourite: Bool { get set }
    var viewModelDidChange: ((DetailsViewModelProtocol) -> ())? { get set }
    init(photo: Photo)
    func favouriteButtonPressed()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    private let photo: Photo
    var title: String {
        photo.title
    }
    var position: String {
        String(photo.albumID) + "/" + String(photo.photoID)
    }
    var image: Data? {
        NetworkManager.shared.getData(from: photo.bigImageURL)
    }
    var isFavourite: Bool {
        get {
            DataManager.shared.getFavouriteStatus(for: photo.title)
        }
        set {
            DataManager.shared.setFavouriteStatus(for: photo.title, with: newValue)
            viewModelDidChange?(self)
        }
    }
    var viewModelDidChange: ((DetailsViewModelProtocol) -> ())?
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func favouriteButtonPressed() {
        isFavourite.toggle()
    }
}

class A: UITabBarController {
    override func viewDidLoad() {
        viewControllers?.forEach({ vc in
            print("")
        })
    }
}
