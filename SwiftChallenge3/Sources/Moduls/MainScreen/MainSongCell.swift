//
//  MainSongCell.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 22.09.2022.
//

import Foundation
import UIKit


class RecentlyCell: MainSongCell {
}

class MainSongCell: UITableViewCell {
    
static let reuseIdentifier = String(describing: MainSongCell.self)
    
    public lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Default header"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    } ()
    
    
    private lazy var songCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        return collectionView
    } ()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private Methods
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.songCollection)
        
        self.contentView.backgroundColor = .black
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(self.snp_topMargin)
            make.leading.equalTo(self.snp_leadingMargin)
            make.trailing.equalTo(self.snp_trailingMargin)
            make.bottom.equalTo(self.snp_bottomMargin)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp_topMargin)
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.height.equalTo(50)
        }
        
        songCollection.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp_bottomMargin)
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.bottom.equalTo(contentView.snp_bottomMargin)
        }
    }
}
//MARK: - delegate Cell
extension MainSongCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height)
        return CGSize(width: height/1.5, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.sideInset
    }
}

//MARK: - dataSource Cell
extension MainSongCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        //     self.isSkeletonable = true
        //     self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(5))
        //    self.stopSkeletonAnimation()
        //   self.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(5))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
