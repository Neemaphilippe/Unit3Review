//
//  PodcastInfo.swift
//  Unit3Review
//
//  Created by Pursuit on 9/18/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import Foundation

struct PodcastInfo: Codable {
    let results: [Podcast]
    
}
struct Podcast: Codable {
    let trackId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl60: String
    let artworkUrl100: String
}
