//
//  MainCollectionView.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 07.10.2022.
//
import UIKit

//final class MainCollectionView: UICollectionView {
//    
//    typealias TabCell = MainsTableViewCell
//    
//    // MARK: - UICollectionView
//    
//    convenience init() {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = Constants.spaceBetweenElements
//        layout.scrollDirection = .horizontal
//        layout.sectionInset = Constants.sectionInset
//        self.init(frame: .zero, collectionViewLayout: layout)
//        configureAppearance()
//        registerCells()
//    }
//    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//}
//
//// MARK: - Private Methods
//
//private extension MainCollectionView {
//    
//    func configureAppearance() {
//        showsHorizontalScrollIndicator = false
//    }
//    
//    func registerCells() {
//        register(TabCell.self, forCellWithReuseIdentifier: TabCell.reuseIdentifier)
//    }
//}
//
//// MARK: - Constants
//
//private enum Constants {
//    static let sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//    static let spaceBetweenElements: CGFloat = 8
//}
