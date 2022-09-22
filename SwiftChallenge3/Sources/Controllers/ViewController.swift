//
//  ViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let nmc = NetworkService()
        
        nmc.delegate = self
        nmc.fetchData(searchRequest: "Florence", limit: 5)
     
        // Do any additional setup after loading the view.
    }


}

extension ViewController: NetworkServiceDelegate {
    func didFetchTracks(tracks: [TrackModel]) {
        print(tracks)
    }
    
    func didFinishWithError(error: Error) {
        print("Error Fetching Tracks")
        print(error.localizedDescription)
    }
    
    
}

