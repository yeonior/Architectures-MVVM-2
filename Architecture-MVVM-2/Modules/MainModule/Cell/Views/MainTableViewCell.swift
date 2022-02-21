//
//  MainTableViewCell.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 21.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var photoPositionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var favouriteLabel: UILabel!
    
    var viewModel: MainTableViewCellViewModelProtocol! {
        didSet {
            photoPositionLabel.text = viewModel.position
            if let imageData = viewModel.image {
                photoImageView.image = UIImage(data: imageData)
            } else {
                photoImageView.image = UIImage(systemName: "nosign")!
            }
            photoTitleLabel.text = viewModel.title
            favouriteLabel.text = viewModel.isFavourite ? "❤️" : "🤍"
        }
    }
}
