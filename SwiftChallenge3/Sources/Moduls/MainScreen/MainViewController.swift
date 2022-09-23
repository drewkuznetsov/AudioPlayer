//
//  MainViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    //MARK: - private let/var
    var playlist = PlayListModel(playListName: "Recentli Played", tracks: [
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
    ])
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupUI()
    }
    
  var SongTableView: UITableView = {
      let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = .clear
        return tableView
    }()
    //MARK: - Private Methods
    private func configureTableView() {
        SongTableView.register(MainSongCell.self, forCellReuseIdentifier: MainSongCell.reuseIdentifier)
        SongTableView.delegate = self
        SongTableView.dataSource = self
    }
    
    private func setupUI() {
        self.overrideUserInterfaceStyle = .light
        self.view.addSubview(SongTableView)
        
        SongTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
}

//MARK: - Table Delegate
extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did tap on \(playlist.tracks.count)")
    }
}

//MARK: - Table DataSource
extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainSongCell.reuseIdentifier, for: indexPath) as? MainSongCell else {
            return UITableViewCell()
        }
        return cell
    }
}
