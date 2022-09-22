//
//  TrackDataModel.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 22.09.2022.
//

import Foundation

struct Track: Decodable {
    let artistName: String
    let trackName: String
    let collectionName: String?
    let previewUrl: String?
    let artworkUrl100: String?
    
}

struct FetchResults: Decodable {
    let resultCount: Int
    let results: [Track]
}
