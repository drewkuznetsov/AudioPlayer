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
    }
    
// MARK: - RealmManager
    
    private var realmManager = RealmBaseManager()
    
// MARK: - Internal parameter
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let networkService = NetworkService()
    private var tracks: [TrackModel] = []
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
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as? TrackTableViewCell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defoultCell", for: indexPath)
            let track = self.tracks[indexPath.row]
            cell.textLabel?.text = track.trackName + "\n" + track.artistName
            cell.textLabel?.numberOfLines = Constants.tableCell.numberOfLines
            if let coverURL = track.coverURL?.replacingOccurrences(of: "100x100", with: "600x600") {
                cell.imageView?.downloadedFrom(link: coverURL)
            }
            return cell
        }
        let track = self.tracks[indexPath.row]
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
        let track = tracks[indexPath.row]
        realmManager.addToRecentPlayed(track: track)
        print("Choose in \(track.trackName) in SearchVC")
    }
}

// MARK: - NetworkServiceDelegate

extension SearchViewController: NetworkServiceDelegate {
    
    func didFetchTracks(tracks: [TrackModel]) {
        self.tracks = tracks
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
        self.tracks = []
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
