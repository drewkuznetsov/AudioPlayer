//
//  MainSongCell.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 22.09.2022.
//

import Foundation
import UIKit

//final class MainSongCell: UITableViewCell {
//    
//    //MARK: - Let / Var
//    
//    static let reuseIdentifier = String(describing: MainSongCell.self)
//    
//    var playlist : PlayListModel? {
//        didSet {
//            headerLabel.text = playlist?.playListName
//            self.songCollection.reloadData()
//        }
//    }
//    
//    //MARK: - Lazy var
//    
//    private lazy var headerLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Header"
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        return label
//    } ()
//    
//    private lazy var songCollection: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
//        return collectionView
//    } ()
//    
//    //MARK: - Override func
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.setupView()
//        self.songCollection.reloadData()
//    }
//    
//    //MARK: - Override Methods
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        contentView.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top)
//            make.leading.equalTo(self.snp.leading)
//            make.trailing.equalTo(self.snp.trailing)
//            make.bottom.equalTo(self.snp.bottom).offset(-5)
//        }
//        
//        headerLabel.snp.makeConstraints { make in
//            make.top.equalTo(contentView.snp.top)
//            make.leading.equalTo(contentView.snp.leading)
//            make.height.equalTo(50)
//        }
//        
//        songCollection.snp.makeConstraints { make in
//            make.top.equalTo(headerLabel.snp.bottom)
//            make.leading.equalTo(contentView.snp.leading)
//            make.trailing.equalTo(contentView.snp.trailing)
//            make.bottom.equalTo(contentView.snp.bottom)
//        }
//    }
//    
//    //MARK: - Private Methods
//    
//    private func setupView () {
//        self.addSubview(contentView)
//        self.contentView.addSubview(self.headerLabel)
//        self.contentView.addSubview(self.songCollection)
//    }
//}
//
////MARK: - Extension + Delegate
//
//extension MainSongCell: UICollectionViewDelegateFlowLayout {
//    
//    private var sideInset: CGFloat { return 12 }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (collectionView.bounds.height)
//        return CGSize(width: height/1.5, height: height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        self.sideInset
//    }
//}
//
////MARK: - Extension + DataSource
//extension MainSongCell: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return playlist?.tracks.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        
//        cell.track = playlist?.tracks[indexPath.row]
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Selected track - `\(playlist?.tracks[indexPath.row].trackName ?? "Selected cell in MainSongCell")` in MainSongCell")
//    }
//}









//     self.isSkeletonable = true
//     self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(5))
//    self.stopSkeletonAnimation()
//   self.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(5))
