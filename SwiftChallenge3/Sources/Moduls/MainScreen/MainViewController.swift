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
        TrackModel(trackID: 0, trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackID: 1, trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackID: 2, trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackID: 3, trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
        TrackModel(trackID: 4, trackName: "trackName", artistName: "artistName", albumName: "AlbumName", coverURL: "coverURL", previewURL: "previewURL"),
    ])
    
    var trackArray = [TrackModel]() {
        didSet {
            self.SongTableView.reloadData()
        }
    }
    //MARK: - LifeCycle viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.view = self.SongTableView
        navigationItem.title = "Айтюнс"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        setupUI()
    }
    //Создаём таблицу на весь фрейм Вью.
   private lazy var SongTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = .clear
        return tableView
    }()
    
    //MARK: - Private Methods
    ///Подписка на делегат/датасорс. Регистрация ниба
    private func configureTableView() {
        SongTableView.register(MainSongCell.self, forCellReuseIdentifier: MainSongCell.reuseIdentifier)
        SongTableView.delegate = self
        SongTableView.dataSource = self
    }
    
    ///Добавление Таблицы в MainVC.
    private func setupUI() {
        self.overrideUserInterfaceStyle = .light
        self.view.addSubview(SongTableView)
        
        SongTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(90)
//            make.bottom.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
    
    //Кейсы
    enum SongTableSection: Int {
        case madeForYou
        case recently
        
        var title: String {
            switch self {
            case .madeForYou:
                return "Made for yoy"
            case .recently:
                return "Recently Played"
            }
        }
    }
}

//MARK: - Table Delegate
extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did tap on \(playlist.tracks.count) in MainViewController" )
    }
    
}

//MARK: - Table DataSource
extension MainViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let naming = SongTableSection(rawValue: 0)
//        if section == 0 {
//            return SongTableSection.madeForYou.title
//        } else if section == 1 {
//            return SongTableSection.recently.title
//        } else {
//            return "Another Track"
//        }
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        self.playlist.tracks.isEmpty ? 2 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainSongCell.reuseIdentifier, for: indexPath) as? MainSongCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if playlist.playListName.count == 0 {
            switch indexPath.section {
            case 0: return (self.view.frame.size.height)/2.5
            case 1: return (self.view.frame.size.height)/2.8
            default: return 0
            }
        } else {
            switch indexPath.section {
            case 0: return (self.view.frame.size.height)/2.5
            case 1: return (self.view.frame.size.height)/2.8
            case 2: return (self.view.frame.size.height)/3
            default: return 0
            }
        }
    }
    func makeSongCell(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let section = SongTableSection(rawValue: indexPath.section)!
        
        let song: [TrackModel] = {
            switch section {
            case .madeForYou:
                return self.trackArray
            case .recently:
                return self.trackArray
                
            }
        }()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainSongCell.reuseIdentifier, for: indexPath) as! MainSongCell
        cell.trackArray = song
        return cell
        
    }
}

