
import UIKit
import SnapKit

///Вспомогательная ячейка  содержащая в себе постер, имя, дату.
class CollectionViewCell: UICollectionViewCell {
    //MARK: - static let
    static let reuseIdentifier = String(describing: CollectionViewCell.self)
    
    //MARK: - var
    private lazy var trackImageView: UIImageView = {
        let poster = UIImageView()
        poster.backgroundColor = .clear
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 16
        poster.sizeToFit()
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false

        return poster
    }()
    
    private lazy var trackNameLabel: UILabel = {
        let name = UILabel()
        name.backgroundColor = .clear
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "Name"
        name.textColor = .lightGray
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .clear
        date.font = .systemFont(ofSize: 16, weight: .regular)
        date.text = "Date"
        date.textColor = .lightGray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    //MARK: - override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp_leadingMargin)
            make.bottom.equalTo(trackNameLabel.snp_topMargin)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.bottom.equalTo(artistNameLabel.snp_topMargin)
            make.height.equalTo(27)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp_bottomMargin)
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.height.equalTo(20)
        }
    }
    
    private func setupView() {
        contentView.addSubview(self.trackImageView)
        contentView.addSubview(self.trackNameLabel)
        contentView.addSubview(self.artistNameLabel)
    }
    //MARK: - Public Methods
    public func setupCell(title: String, release_Date: String, posterURL: URL?) {
        //        self.isSkeletonable = true
        //        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(1))
        self.trackNameLabel.text = title
        self.artistNameLabel.text = DateFromWebtoApp(release_Date)
        self.trackImageView.image = UIImage(named: "\(posterURL)")
        //        self.stopSkeletonAnimation()
        //        self.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(1))
    }
    
    func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL {
            trackImageView.downloadedFrom(link: coverURL)
        }
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
}

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
