import Foundation

protocol NetworkServiceDelegate {
    func didFetchTracks(tracks: [TrackModel])
    func didFinishWithError(error: Error)
}

class NetworkService {
    
    var delegate: NetworkServiceDelegate?
    
    func fetchData(searchRequest:String, limit: Int) {
        
        guard let url = getURLOfRequest(for: searchRequest, limit: limit) else { return }
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                self.delegate?.didFinishWithError(error: error)
                return
            }
            
            if let data = data {
                if let trackResult = self.parseJSON(data) {
                    let tracks = trackResult.map { track in
                        return TrackModel(
                            trackID: track.trackId, 
                            trackName: track.trackName,
                            artistName: track.artistName,
                            albumName: track.collectionName ?? "",
                            coverURL: track.artworkUrl100 ?? "",
                            previewURL: track.previewUrl ?? "")
                    }
                    self.delegate?.didFetchTracks(tracks: tracks)
                }
            }
        }
        task.resume()
    }
}

// MARK: - Private Methods

private extension NetworkService {
    
    func parseJSON(_ tracksData: Data) -> [Track]? {
        let decoder = JSONDecoder()
        do{
            let result = try decoder.decode(FetchResults.self, from: tracksData)
            return result.results
        } catch {
            self.delegate?.didFinishWithError(error: error)
            return nil
        }
    }
    
    func getURLOfRequest(for searchRequest: String, limit: Int) -> URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        
        let searchItem = URLQueryItem(name: "term", value: searchRequest)
        let mediaItem = URLQueryItem(name: "media", value: "music")
        let limitItem = URLQueryItem(name: "limit", value: "\(limit)")
        
        components.queryItems = [
            searchItem,
            mediaItem,
            limitItem
        ]
        
        return components.url
    }
}
