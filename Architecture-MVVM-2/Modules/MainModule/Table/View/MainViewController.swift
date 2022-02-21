//
//  MainViewController.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak var photoTableView: UITableView!
    
    var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchPhotos {
                DispatchQueue.main.async {
                    self.photoTableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
        photoTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCell")
//        photoTableView.estimatedRowHeight = 90
//        photoTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoTableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainTableViewCell {
            
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            
            return cell
        }
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AssemblyBuilder.createDetailsModule()
        vc.viewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
