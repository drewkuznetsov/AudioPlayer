
import UIKit
import SnapKit

///Вспомогательная ячейка  содержащая в себе постер, имя, дату.
class CollectionViewCell: UICollectionViewCell {
    //MARK: - Static let
    static let reuseIdentifier = String(describing: CollectionViewCell.self)
    
    //MARK: - Let / Var
    var track : TrackModel! {
        didSet {
            if let coverURL = track.coverURL?.replacingOccurrences(of: "100x100", with: "600x600") {
                trackImageView.downloadedFrom(link: coverURL)
            }
            trackNameLabel.text = track.trackName
            artistNameLabel.text = track.artistName
        }
    }
    
    //Создаём ImageView с картинкой трека.
    private lazy var trackImageView: UIImageView = {
        let poster = UIImageView()
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 16
        poster.sizeToFit()
        poster.image = UIImage(named: "test")
        poster.contentMode = .scaleAspectFill
        return poster
    }()
    
    //Создаём Лейбл с неймингом трека.
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Track Name"
        label.textColor = .black
        return label
    }()
    
    //Создаём Лейбл с неймингом артиста.
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Artist Name"
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        //setup View
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(trackNameLabel.snp.top)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(artistNameLabel.snp.top)
            make.height.equalTo(27)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(20)
        }
    }
    //MARK: - Private Methods
    private func setupView() {
        contentView.addSubview(self.trackImageView)
        contentView.addSubview(self.trackNameLabel)
        contentView.addSubview(self.artistNameLabel)
        
    }
    
    //MARK: - Public Methods
    //        self.isSkeletonable = true
    //        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(1))
    
    //        self.stopSkeletonAnimation()
    //        self.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(1))
}
