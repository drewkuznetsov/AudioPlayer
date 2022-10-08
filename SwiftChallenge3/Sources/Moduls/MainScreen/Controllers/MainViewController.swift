//
//  MainViewControllers.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 06.10.2022.
//

import UIKit

class MainViewController: BaseViewController<MainView> {
    
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
    // MARK: - RealmManager
    
    let realmManager = RealmBaseManager()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realmManager.loadFavourites()
        realmManager.loadRecentPlayed()
    }
}

// MARK: - Private Methodsf

private extension MainViewController {
    
    func setDelegate() {
        selfView.songTableView.delegate = self
        selfView.songTableView.dataSource = self
        realmManager.delegate = self
    }
    
    func setNavigation() {
        navigationItem.title = "Айтюнс"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Delegate + DataSource TableView

extension MainViewController : UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainsTableViewCell.reuseIdentifier, for: indexPath) as? MainsTableViewCell
        else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.playlist = selfView.favourites
            
        } else {
            cell.playlist = selfView.recentlyPlayed
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selfView.favourites?.tracks.count == 0 {
            switch indexPath.section {
            case 0: return (self.view.frame.size.height)/3
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

// MARK: - Realm Base Manager Delegate

extension MainViewController: RealmBaseManagerDelegate {
    
    func showError(error: Error) {
        print("MainViewController - Realm Base Error")
        print(error.localizedDescription)
    }
    
    func favouriteTracksDidLoad(_ playList: PlayListModel) {
        selfView.favourites = playList
        print("MainViewController - FAVOURITES tracks")
    }
    
    func recentPlayedTracksDidLoad(_ playList: PlayListModel) {
        selfView.recentlyPlayed = playList
        print("MainViewController - RECENT tracks")
    }
}
