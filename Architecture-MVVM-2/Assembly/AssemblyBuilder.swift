//
//  AssemblyBuilder.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailsModule() -> DetailsViewController
}

final class AssemblyBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let viewModel = MainViewModel()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
        view.viewModel = viewModel
        
        return view
    }
    
    static func createDetailsModule() -> DetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        
        return vc
    }
}
