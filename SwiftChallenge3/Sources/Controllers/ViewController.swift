//
//  ViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let realm = RealmBaseManager()
    
    var tracks:[TrackModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let nmc = NetworkService()
        
        nmc.delegate = self
        nmc.fetchData(searchRequest: "Florence", limit: 5)
        
        
     
        // Do any additional setup after loading the view.
    }
    
    func realmTest() {
        for track in self.tracks {
            realm.addToFavourites(track: track)
        }
        
        realm.printFavourites()
        
        let track = self.tracks[1]
        print(realm.isFavourite(track: track))
        realm.deleteFromFavourites(track: track)
        realm.printFavourites()
        print(realm.isFavourite(track: track))
        
        realm.addToFavourites(track: track)
        realm.printFavourites()
        print(realm.isFavourite(track: track))
    }
}

extension ViewController: NetworkServiceDelegate {
    func didFetchTracks(tracks: [TrackModel]) {
        DispatchQueue.main.async {
            self.tracks = tracks
            self.realmTest()
        }
        
    }
    
    func didFinishWithError(error: Error) {
        print("Error Fetching Tracks")
        print(error.localizedDescription)
    }
    
    
}

