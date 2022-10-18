import Foundation
import RealmSwift

class TrackBase: Object {
    @Persisted var trackID: Int
    @Persisted var trackName: String
    @Persisted var artistName: String
    @Persisted var albumName: String?
    @Persisted var coverUrl: String?
    @Persisted var previewUrl: String?
    
    func setValue(track: TrackModel) {
        self.trackID = track.trackID
        self.trackName = track.trackName
        self.artistName = track.artistName
        self.albumName = track.albumName
        self.coverUrl = track.coverURL
        self.previewUrl = track.previewURL
    }
}

class PlayListBase: Object {
    @Persisted(primaryKey: true) var playListName: String
    @Persisted var tracks: List<TrackBase>
}
