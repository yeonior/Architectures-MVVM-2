//
//  DataManager.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 21.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private let userDefaults = UserDefaults()
    
    func setFavouriteStatus(for name: String, with status: Bool) {
        userDefaults.set(status, forKey: name)
    }
    
    func getFavouriteStatus(for name: String) -> Bool {
        userDefaults.bool(forKey: name)
    }
}
