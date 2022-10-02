//
//  SearchViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let searchLimit = 25
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    private let networkService = NetworkService()
    
    private var tracks: [TrackModel] = []
    
    private var timer: Timer?
    
    private var realmManager = RealmBaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search"
        
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defoultCell")
        
        self.setupSearchBar()
        
        self.networkService.delegate = self
    }
    
    private func setupSearchBar() {
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as? TrackTableViewCell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defoultCell", for: indexPath)
            let track = self.tracks[indexPath.row]
            cell.textLabel?.text = track.trackName + "\n" + track.artistName
            cell.textLabel?.numberOfLines = 2
            if let coverURL = track.coverURL?.replacingOccurrences(of: "100x100", with: "600x600") {
                cell.imageView?.downloadedFrom(link: coverURL)
            }
            return cell
        }
        let track = self.tracks[indexPath.row]
        cell.track = track
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        realmManager.addToRecentPlayed(track: track)
        print("Segue in controller player")
    }
}

//MARK: - Extensions

extension SearchViewController: NetworkServiceDelegate {
    
    func didFetchTracks(tracks: [TrackModel]) {
        self.tracks = tracks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFinishWithError(error: Error) {
        print("Error fetching tracks!")
        print(error.localizedDescription)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.networkService.fetchData(searchRequest: searchText, limit: self.searchLimit)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tracks = []
        self.tableView.reloadData()
    }
    
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
