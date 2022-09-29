//
//  RealmBaseManager.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 23.09.2022.
//

import Foundation
import RealmSwift

struct PlaylistNames {
    static let favourite = "Favourite"
    static let recentPlayed = "Recent Played"
}


protocol RealmBaseManagerDelegate {
    func showError(error: Error)
    func favouriteTracksDidLoad(_ playList: PlayListModel)
    func recentPlayedTracksDidLoad(_ playList: PlayListModel)
}


class RealmBaseManager {
    
    var delegate: RealmBaseManagerDelegate?
    
    private let realmManager: Realm = {
//        let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
//        let path = URL(fileURLWithPath: paths[0].path + "/RealmBase.realm")
//        let manager = try! Realm(fileURL: path)
        let manager = try! Realm()
        return manager
    }()
    
    init() {
        
        if let _ = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.favourite) { return }
        
        let favourites = PlayListBase()
        favourites.playListName = PlaylistNames.favourite

        do {
            try realmManager.write({
                self.realmManager.add(favourites)
            })
        } catch {
            print(error)
        }
    }
}

//MARK: - Favourites Track

extension RealmBaseManager {
    
    func addToFavourites(track: TrackModel) {
        
        guard let favourites = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.favourite) else { return }
        
        if self.isFavourite(track: track) { return }
        
        do {
            try realmManager.write({
                let newTrack = TrackBase()
                newTrack.setValue(track: track)
                favourites.tracks.insert(newTrack, at: 0)
            })
        } catch {
            delegate?.showError(error: error)
        }
    }
    
    func loadFavourites() {
        
        guard let favourites = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.favourite) else { return }
        
        var playList = PlayListModel(playListName: PlaylistNames.favourite)
       
        playList.tracks = favourites.tracks.map({ track in
            TrackModel(trackID: track.trackID,
                       trackName: track.trackName,
                       artistName: track.artistName,
                       albumName: track.albumName,
                       coverURL: track.coverUrl,
                       previewURL: track.previewUrl)
        })
        
        self.delegate?.favouriteTracksDidLoad(playList)
    }
    
    func deleteFromFavourites(track: TrackModel) {
        guard let favourites = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.favourite) else { return }
        
        guard let trackIndex = favourites.tracks.firstIndex(where: { $0.trackID == track.trackID}) else { return }
        
        do {
            try realmManager.write({
                favourites.tracks.remove(at: trackIndex)
            })
        } catch {
            delegate?.showError(error: error)
        }
    }
    
    func isFavourite(track: TrackModel) -> Bool {
        
        guard let favourites = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.favourite) else { return false }
        
        return favourites.tracks.first(where: {$0.trackID == track.trackID}) != nil
    }
}

//MARK: - Reacent Played

extension RealmBaseManager {
    
    func addToRecentPlayed(track: TrackModel) {
        
        guard let recentPlayed = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.recentPlayed) else { return }
        
        var newTrack = TrackBase()
        
        if let trackIndex = recentPlayed.tracks.firstIndex(where: { $0.trackID == track.trackID }) {
            do {
                try realmManager.write({
                    newTrack = recentPlayed.tracks[trackIndex]
                    recentPlayed.tracks.remove(at: trackIndex)
                    recentPlayed.tracks.insert(newTrack, at: 0)
                })
            } catch {
                delegate?.showError(error: error)
            }
        } else {
            do {
                try realmManager.write({
                    newTrack.setValue(track: track)
                    recentPlayed.tracks.insert(newTrack, at: 0)
                })
            } catch {
                delegate?.showError(error: error)
            }
        }
    }
    
    func loadRecentPlayed() {
        
        guard let recentPlayed = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.recentPlayed) else { return }
        
        var playList = PlayListModel(playListName: PlaylistNames.recentPlayed)
       
        playList.tracks = recentPlayed.tracks.map({ track in
            TrackModel(trackID: track.trackID,
                       trackName: track.trackName,
                       artistName: track.artistName,
                       albumName: track.albumName,
                       coverURL: track.coverUrl,
                       previewURL: track.previewUrl)
        })
        
        self.delegate?.recentPlayedTracksDidLoad(playList)
    }
    
    func isRecentPlayed(track: TrackModel) -> Bool {
        
        guard let recentPlayed = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.recentPlayed) else { return false }
        
        return recentPlayed.tracks.first(where: { $0.trackID == track.trackID}) != nil
    }
}

//MARK: - Debug

extension RealmBaseManager {
    
    func printFavourites() {
        guard let favourites = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.favourite) else { return }
        print("FAVOURITES:")
        for track in favourites.tracks {
            print("\(track.trackID) \(track.trackName)")
        }
        print("\n")
    }
    
    func printRecentPlayed() {
        guard let recentPlayed = self.realmManager.object(ofType: PlayListBase.self, forPrimaryKey: PlaylistNames.recentPlayed) else { return }
        print("RECENT PLAYED:")
        for track in recentPlayed.tracks {
            print("\(track.trackID) \(track.trackName)")
        }
        print("\n")
    }
}
