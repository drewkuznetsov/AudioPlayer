//
//  MainsTableViewCell.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 07.10.2022.
//

import UIKit
import SnapKit

class MainsTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    static let reuseIdentifier = String(describing: MainsTableViewCell.self)
    
    var playlist : PlayListModel? {
        didSet {
            headerLabel.text = playlist?.playListName
            self.songCollection.reloadData()
        }
    }
    
    // MARK: - Constants
    private enum Constants {
        
        enum ContentView {
            static let bot : CGFloat = -5
        }
        
        enum HeaderLabel {
            static let height : CGFloat = 50
        }
        
        enum SongCollection {
            static let sideInset : CGFloat = 15
            static let sideHeight : CGFloat = 1.5
        }
    }
    
    // MARK: - UI Elements
    let headerLabel = UILabel()
    var songCollection = MainsTableViewCell.makeSongCollection()
    
    //MARK: - Override methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSongCollection()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSongCollection()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.configureHeader()
        self.setupView()
        self.setupDelegate()
        self.songCollection.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom).offset(Constants.ContentView.bot)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.height.equalTo(Constants.HeaderLabel.height)
        }

        songCollection.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
  
    //MARK: - Private Methods
    
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.songCollection)
    }
    private func configureHeader() {
        headerLabel.textColor = .black
        headerLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
    }
    private func configureSongCollection() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        songCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        songCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    }
    
    private func setupDelegate() {
        songCollection.delegate = self
        songCollection.dataSource = self
    }
}
// MARK: - Creating Subviews

extension MainsTableViewCell {
    
    static func makeSongCollection() -> UICollectionView {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
                let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
                return collectionView
            }
    }

//MARK: - UICollection Delegate

extension MainsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height)
        return CGSize(width: height/Constants.SongCollection.sideHeight, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.SongCollection.sideInset
    }
}

//MARK: - UICollection DataSource
extension MainsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist?.tracks.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.track = playlist?.tracks[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected track - `\(playlist?.tracks[indexPath.row].trackName ?? "Selected cell in MainSongCell")` in MainSongCell")
    }
}
