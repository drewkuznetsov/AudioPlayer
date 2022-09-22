//
//  ListViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

struct PlaylistTest {
    let title: String
    let tracks: [TrackTest]
}

struct TrackTest {
    let trackName: String
    let artistName: String
    let image: String
    let plays: Int
}

class ListViewController: UITableViewController {
    
    var playlist = PlaylistTest(title: "Recently Played", tracks: [
        TrackTest(trackName: "Gbona", artistName: "Burna bov", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "On the low", artistName: "Mavorkin", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "Sope", artistName: "Mavorun", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "Sunshine", artistName: "Bez", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "Image", artistName: "Burna", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "Ride", artistName: "Bov", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "Real", artistName: "Ruslan", image: "test", plays: Int.random(in: 0...10_000)),
        TrackTest(trackName: "Andrey", artistName: "Vasiliy", image: "test", plays: Int.random(in: 0...10_000)),
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
    }
    
    func configurePlaylist(_ playlist: PlaylistTest) {
        title = self.playlist.title
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
