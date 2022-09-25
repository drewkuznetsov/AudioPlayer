
import UIKit
import SnapKit

///Вспомогательная ячейка  содержащая в себе постер, имя, дату.
class CollectionViewCell: UICollectionViewCell {
    //MARK: - Static let
    static let reuseIdentifier = String(describing: CollectionViewCell.self)
    
    //MARK: - Let / Var
    //Создаём ImageView с картинкой трека.
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
    
    //Создаём Лейбл с неймингом трека.
    private lazy var trackNameLabel: UILabel = {
        let name = UILabel()
        name.backgroundColor = .clear
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "Name"
        name.textColor = .lightGray
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    //Создаём Лейбл с неймингом артиста.
    private lazy var artistNameLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .clear
        date.font = .systemFont(ofSize: 16, weight: .regular)
        date.text = "Date"
        date.textColor = .lightGray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    //MARK: - Override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
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
///Конфигурируем Ячейку под TrackModel.
  public func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL {
            trackImageView.downloadedFrom(link: coverURL)
        }
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
}
