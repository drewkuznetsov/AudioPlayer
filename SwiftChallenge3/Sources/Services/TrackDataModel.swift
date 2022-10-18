import Foundation

struct Track: Decodable {
    let trackId: Int
    let artistName: String
    let trackName: String
    let collectionName: String?
    let previewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    
}

struct FetchResults: Decodable {
    let resultCount: Int
    let results: [Track]
}
