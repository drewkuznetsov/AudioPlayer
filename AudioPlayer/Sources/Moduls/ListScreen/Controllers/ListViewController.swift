import UIKit

class ListViewController: BaseViewController<ListView> {
    
    // MARK: - RealmManager
    
    var realmManager = RealmBaseManager()
    
    // MARK: - Playlist
    
    var playList: PlayListModel? {
        didSet {
            title = playList?.playListName
            selfView.trackTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSortButton()
        setupDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        realmManager.loadFavourites()
    }
}

// MARK: - Private Methods

private extension ListViewController {
    
    func setupSortButton() {
        let sortButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(sortPlaylist))
        sortButtonItem.image = UIImage(systemName: "list.bullet.indent")
        sortButtonItem.tintColor = UIColor.tabBarItemAccent
        self.navigationItem.rightBarButtonItem  = sortButtonItem
    }
    
    func setupDelegate() {
        selfView.trackTableView.delegate = self
        selfView.trackTableView.dataSource = self
        realmManager.delegate = self
    }
}

// MARK: - @Objc Private Methods

@objc
private extension ListViewController {
    
    func sortPlaylist() {
        print("Sort Playlist")
    }
}


// MARK: - DataSource + TableView

extension ListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList?.tracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as? TrackTableViewCell else {
            return UITableViewCell()
        }
        cell.track = playList?.tracks[indexPath.row]
        return cell
    }
}

// MARK: - Delegate + TableView

extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let track = playList?.tracks[indexPath.row] else { return }
        realmManager.addToRecentPlayed(track: track)
        print("Segue in controller player")
    }
}

// MARK: - Realm Base Manager Delegate

extension ListViewController: RealmBaseManagerDelegate {
    
    func showError(error: Error) {
        print("!!!ListViewController - Realm Base Error!!!")
        print(error.localizedDescription)
    }
    
    func favouriteTracksDidLoad(_ playList: PlayListModel) {
        self.playList = playList
    }
    
    func recentPlayedTracksDidLoad(_ playList: PlayListModel) {
    }
}
