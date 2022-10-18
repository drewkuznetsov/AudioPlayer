import Foundation

struct PlayListModel {
    
    var playListName: String
    var tracks: [TrackModel] = []
    
    var currentIndex: Int {
        set {
            if newValue < 0 {
                self.trackIndex = 0
                return
            }
            
            if newValue < tracks.count {
                self.trackIndex = newValue
            } else {
                self.trackIndex = tracks.count - 1
            }
        }
        
        get {
            return trackIndex
        }
    }
    
    var currentTrack: TrackModel {
        return tracks[trackIndex]
    }
    
    private var trackIndex: Int = 0
    
    init(playListName: String, tracks: [TrackModel]) {
        self.playListName = playListName
        self.tracks = tracks
    }
    
    init(playListName: String) {
        self.playListName = playListName
    }
}
