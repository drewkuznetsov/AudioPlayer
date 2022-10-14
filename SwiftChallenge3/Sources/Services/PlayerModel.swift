//
//  PlayerModel.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 12.10.2022.
//

import Foundation
import AVKit

protocol AudioPlayerDelegate {
    func trackPlay(track: TrackModel)
    func timeChaneged()
}

protocol MiniAudioPlayerDelegate {
    func trackPlay(track: TrackModel)
}

enum Constats {
    static let minPlayTime = 3.0
}

class AudioPlayer {

//MARK: - Audio Player Delegate
    
    var delegate: AudioPlayerDelegate?
    var miniDelegate: MiniAudioPlayerDelegate?
    
//MARK: - Static Audio Player
    
    static let mainPlayer = AudioPlayer()
    
    private let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var currentPlayList: PlayListModel?
    
//MARK: - Realm Base manager
    
    private let realmManager = RealmBaseManager()
    
//MARK: - Time Vars
    
    private var time = CMTime()
    
    private var duaration: CMTime {
        guard let duaration = self.player.currentItem?.duration else { return CMTime(seconds: 0, preferredTimescale: 1)}
        return duaration
    }
    
    var currentTime: String {
        return self.convertTimeToString(time: time)
    }
    
    var durationTime: String {
        guard let duaration = self.player.currentItem?.duration else { return "--:--"}
        return self.convertTimeToString(time: duaration)
    }
    
    var timeLeft: String {
        guard let duaration = self.player.currentItem?.duration else { return "--:--"}
        let timeLeft = duaration - self.time
        return self.convertTimeToString(time: timeLeft)
    }
    
    var timePercent: Float {
        let curentTime = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        return Float(curentTime / durationTime)
    }
    
//MARK: - Public Controlls
    
    func playList(playList: PlayListModel) {
        self.currentPlayList = playList
        if let track = self.currentPlayList?.currentTrack {
            self.playTrack(track: track)
        }
    }
    
    // Play Current Track
    func playTrack(track: TrackModel) {
        guard let previewURL = track.previewURL else { return }
        guard let url = URL(string: previewURL) else { return }
        let playerItem = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: playerItem)
        self.player.play()
        self.observePlayerCurrentTime()
        self.delegate?.trackPlay(track: track)
        self.miniDelegate?.trackPlay(track: track)
        self.realmManager.addToRecentPlayed(track: track)
    }
    
    func playTrack() {
        self.player.play()
    }
    
    func pauseTrack() {
        self.player.pause()
    }
    
    func nextTrack() {
        self.currentPlayList?.currentIndex += 1
        if let track = self.currentPlayList?.currentTrack {
            self.playTrack(track: track)
        }
    }
    
    func previousTrack() {
        
        let curentTime = CMTimeGetSeconds(player.currentTime())
        if curentTime > Constats.minPlayTime {
            self.setTrackPosition(percents: 0)
            return
        }
        
        self.currentPlayList?.currentIndex -= 1
        if let track = self.currentPlayList?.currentTrack {
            self.playTrack(track: track)
        }
    }
    
    var playStatus: AVPlayer.TimeControlStatus {
        return self.player.timeControlStatus
    }
    
    var currentTrack: TrackModel? {
        guard let track = self.currentPlayList?.currentTrack else {return nil}
        return track
    }
    
    // Set Track Position
    func setTrackPosition(percents: Float) {
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percents) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    func setPlayerVolume(volume: Float) {
        self.player.volume = volume
    }
    
//MARK: - Private Funcs
    
    private func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.time = time
            self?.delegate?.timeChaneged()
        }
    }
    
    private func convertTimeToString(time: CMTime) -> String {
        guard !CMTimeGetSeconds(time).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(time))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%2d:%2d", minutes, seconds)
        return timeFormatString
    }
}
