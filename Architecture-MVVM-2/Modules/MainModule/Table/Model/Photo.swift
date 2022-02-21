//
//  Photo.swift
//  Architecture-MVVM-2
//
//  Created by Ruslan on 20.02.2022.
//  Copyright © 2022 Ruslan. All rights reserved.
//

struct Photo: Decodable {
    let albumID: Int
    let photoID: Int
    let title: String
    let bigImageURL: String
    let smallImageURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case photoID = "id"
        case title
        case bigImageURL = "url"
        case smallImageURL = "thumbnailUrl"
    }
}
