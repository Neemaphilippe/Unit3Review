//
//  FavoritePodcast.swift
//  Unit3Review
//
//  Created by Pursuit on 9/18/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import Foundation

struct FavoritePodcast: Codable {
    let trackId: Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}
