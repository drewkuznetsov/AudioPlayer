//
//  ListViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

class ListViewController: UITableViewController {
    
    var playlist = PlayListModel(playListName: "Recentli Played", tracks: [
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
    }
    
    private func configureTableView() {
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)
    }
    
    private func configureUI() {
        let sortButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(sortPlaylist))
        sortButtonItem.image = UIImage(systemName: "list.bullet.indent")
        self.navigationItem.rightBarButtonItem  = sortButtonItem
        title = "Плейлист"
    }
    
    func configurePlaylist(_ playlist: PlayListModel) {
        title = self.playlist.playListName
        self.playlist = playlist
    }
    
    @objc private func sortPlaylist() {
        print("Sort Playlist")
    }
}

// MARK: - TableView data source

extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as? TrackTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(playlist.tracks[indexPath.row])
        return cell
    }
}

// MARK: - TableView delegate

extension ListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Segue in controller player")
    }
}
