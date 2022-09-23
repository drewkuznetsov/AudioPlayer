
import UIKit
import SnapKit


class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CollectionViewCell.self)
    
    public func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let thisDate = dateFormatter.string(from: date!)
        let first = String(thisDate.prefix(1)).capitalized
        let other = String(thisDate.dropFirst())
        return first+other
    }
    
    private lazy var posterView: UIImageView = {
        let poster = UIImageView()
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 16
        poster.sizeToFit()
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.backgroundColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "default"
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .black
        date.font = .systemFont(ofSize: 16, weight: .regular)
        date.text = "Default"
        date.textColor = .lightGray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.posterView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.dateLabel)
        posterView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp_leadingMargin)
            make.bottom.equalTo(nameLabel.snp_topMargin)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.bottom.equalTo(dateLabel.snp_topMargin)
            make.height.equalTo(27)
            
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp_bottomMargin)
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.height.equalTo(20)
        }
        
    }
    
    
    
    func setupCell(title: String, release_Date: String, posterURL: URL?) {
//        self.isSkeletonable = true
//        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(1))
        
        self.nameLabel.text = title
        self.dateLabel.text = DateFromWebtoApp(release_Date)
        self.posterView.image = UIImage(named: "\(posterURL)")
        
//        self.stopSkeletonAnimation()
//        self.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(1))
    }
    
}

////MARK: - dataSource Cell
//extension CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        
//        //     self.isSkeletonable = true
//        //     self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(5))
//        //    self.stopSkeletonAnimation()
//        //   self.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(5))
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
//}
