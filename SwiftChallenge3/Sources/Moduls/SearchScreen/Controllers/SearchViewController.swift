import UIKit

class SearchViewController: BaseViewController<SearchView> {
    
// MARK: - Constants
    
    private enum Constants {
        
        enum SearchLimit {
            static let limit : Int = 50
        }
        
        enum tableCell {
            static let numberOfLines : Int = 2
        }
        
        enum SongTable {
            static let height : CGFloat = 90
            static let numberOfSection : Int = 1
        }
        
        enum PlayList {
            static let name: String = "Search"
        }
    }
    
// MARK: - RealmManager
    
    private var realmManager = RealmBaseManager()
    
// MARK: - Internal parameter
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let networkService = NetworkService()
//    private var tracks: [TrackModel] = []
    private var playList = PlayListModel(playListName: Constants.PlayList.name)
    private var timer: Timer?
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selfView.trackTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.SongTable.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as? TrackTableViewCell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defoultCell", for: indexPath)
            let track = self.playList.tracks[indexPath.row]
            cell.textLabel?.text = track.trackName + "\n" + track.artistName
            cell.textLabel?.numberOfLines = Constants.tableCell.numberOfLines
            if let coverURL = track.coverURL?.replacingOccurrences(of: "100x100", with: "600x600") {
                cell.imageView?.downloadedFrom(link: coverURL)
            }
            return cell
        }
        let track = self.playList.tracks[indexPath.row]
        cell.track = track
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.SongTable.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playList.currentIndex = indexPath.row
        AudioPlayer.mainPlayer.playList(playList: self.playList)
    }
}

// MARK: - NetworkServiceDelegate

extension SearchViewController: NetworkServiceDelegate {
    
    func didFetchTracks(tracks: [TrackModel]) {
        self.playList.tracks = tracks
        DispatchQueue.main.async {
            self.selfView.trackTableView.reloadData()
        }
    }
    
    func didFinishWithError(error: Error) {
        print("Error fetching tracks!")
        print(error.localizedDescription)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.networkService.fetchData(searchRequest: searchText, limit: Constants.SearchLimit.limit)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.playList = PlayListModel(playListName: Constants.PlayList.name)
        selfView.trackTableView.reloadData()
    }
}

// MARK: - Private Methods

private extension SearchViewController  {
    
    func setupSearchBar() {
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupDelegate() {
        searchController.searchBar.delegate = self
        selfView.trackTableView.delegate = self
        selfView.trackTableView.dataSource = self
        networkService.delegate = self
    }
}
