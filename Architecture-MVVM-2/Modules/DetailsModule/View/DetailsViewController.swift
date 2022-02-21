//
//  DetailsViewController.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoPositionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var viewModel: DetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setStatusForFavouriteButton()
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            setStatusForFavouriteButton()
        }
        // not needed binding because of the static data
        photoTitleLabel.text = viewModel.title
        photoPositionLabel.text = viewModel.position
        if let imageData = viewModel.image {
            photoImageView.image = UIImage(data: imageData)
        } else {
            photoImageView.image = UIImage(systemName: "nosign")!
        }
    }
    
    @IBAction func didTapFavouriteButton(_ sender: UIButton) {
        viewModel.favouriteButtonPressed()
    }
    
    private func setStatusForFavouriteButton() {
        favouriteButton.tintColor = viewModel.isFavourite ? .systemPink : .gray
    }
}

