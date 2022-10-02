//
//  MainViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import SnapKit
import UIKit

enum SongTableSection: Int {
    case favourite
    case recently
    
    var title: String {
        switch self {
        case .favourite:
            return "Made for yoy"
        case .recently:
            return "Recently Played"
        }
    }
}

class MainViewController: UIViewController {
    
    //MARK: - Let / Var
    var favourites: PlayListModel? {
        didSet {
            SongTableView.reloadData()
            print("FAVOURITES UPDATED")
        }
    }
    
    var recentlyPlayed: PlayListModel? {
        didSet {
            SongTableView.reloadData()
            print("RECENT UPDATED")
        }
    }
    
    let realmManager = RealmBaseManager()
    
    //Создаём таблицу на весь фрейм Вью.
    private lazy var SongTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = .clear
        return tableView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmManager.delegate = self
        
        navigationItem.title = "Айтюнс"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        configureSongTableView()
        setupUI()
    }
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realmManager.loadFavourites()
        realmManager.loadRecentPlayed()
    }
    //MARK: - Private Methods
    ///Подписка на делегат/датасорс. Регистрация ниба
    private func configureSongTableView() {
        SongTableView.register(MainSongCell.self, forCellReuseIdentifier: MainSongCell.reuseIdentifier)
        SongTableView.delegate = self
        SongTableView.dataSource = self
        self.SongTableView.allowsSelection = false
        SongTableView.sectionHeaderTopPadding = 0
    }
    ///Добавление Таблицы в MainVC.
    private func setupUI() {
        self.overrideUserInterfaceStyle = .light
        self.view.addSubview(SongTableView)
        
        SongTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
}

//MARK: - Delegate + DataSource TableView.
extension MainViewController : UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainSongCell.reuseIdentifier, for: indexPath) as? MainSongCell else {
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            cell.playlist = favourites
        } else {
            cell.playlist = recentlyPlayed
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if favourites?.tracks.count == 0 {
            switch indexPath.section {
            case 0: return (self.view.frame.size.height)/3.3
            case 1: return (self.view.frame.size.height)/2.9
            default: return 0
            }
        } else {
            switch indexPath.section {
            case 0: return (self.view.frame.size.height)/3.2
            case 1: return (self.view.frame.size.height)/2.8
            case 2: return (self.view.frame.size.height)/3
            default: return 0
            }
        }
    }
}

//MARK: - Realm Base Manager Delegate

extension MainViewController: RealmBaseManagerDelegate {
    
    func showError(error: Error) {
        print("MainViewController - Realm Base Error")
        print(error.localizedDescription)
    }
    
    func favouriteTracksDidLoad(_ playList: PlayListModel) {
        self.favourites = playList
        print("MainViewController - FAVOURITES tracks")
    }
    
    func recentPlayedTracksDidLoad(_ playList: PlayListModel) {
        self.recentlyPlayed = playList
        print("MainViewController - RECENT tracks")
    }
}

