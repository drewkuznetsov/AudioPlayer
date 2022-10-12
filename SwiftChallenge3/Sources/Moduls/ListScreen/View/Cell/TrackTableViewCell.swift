import UIKit
import SnapKit

final class TrackTableViewCell: UITableViewCell {
    
// MARK: - Identifier
    
    static let reuseIdentifier = String(describing: TrackTableViewCell.self)
    
// MARK: - internal Property
    
    var realmManager = RealmBaseManager()
    
// MARK: - Playlist
    
    var track: TrackModel! {
        didSet {
            trackImageView.image = UIImage(named: "test")
            if let coverURL = track.coverURL {
                trackImageView.downloadedFrom(link: coverURL)
            }
            if realmManager.isFavourite(track: track) {
                favoriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: Constants.FavoriteButton.largeConfig), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(systemName: "heart", withConfiguration: Constants.FavoriteButton.largeConfig), for: .normal)
            }
            trackNameLabel.text = track.trackName
            artistNameLabel.text = track.artistName
        }
    }
    
// MARK: - Constants
    
    private enum Constants {
        
        static let indent : CGFloat = 10
        
        enum TrackImageView {
            static let cornerRadius : CGFloat = Constants.TrackImageView.width / 2
            static let width : CGFloat = 70
        }
        
        enum StackView {
            static let top : CGFloat = 25
            static let left : CGFloat = 15
            static let right : CGFloat = -10
            static let bottom : CGFloat = -25
        }
        
        enum TrackNameLabel {
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        }
        
        enum ArtistNameLabel {
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
        
        enum FavoriteButton {
            static let width = 50
            static let pointSize : CGFloat = 16
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.FavoriteButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "heart", withConfiguration: Constants.FavoriteButton.largeConfig)
            static let color = UIColor.systemPink
        }
    }
    
// MARK: - UI Elements
    
    var trackImageView = UIImageView()
    var stackView = UIStackView()
    var trackNameLabel = UILabel()
    var artistNameLabel = UILabel()
    var favoriteButton = UIButton()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(trackImageView)
        contentView.addSubview(favoriteButton)
        
        trackImageView.layer.masksToBounds = true
        trackImageView.layer.cornerRadius = Constants.TrackImageView.cornerRadius
        
        trackImageView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(Constants.indent)
            make.bottom.equalTo(contentView).offset(-Constants.indent)
            make.width.height.equalTo(Constants.TrackImageView.width)
        }
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(trackNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(Constants.StackView.top)
            make.left.equalTo(trackImageView.snp.right).offset(Constants.StackView.left)
            make.right.equalTo(favoriteButton.snp.left).offset(Constants.StackView.right)
            make.bottom.equalTo(contentView).offset(Constants.StackView.bottom)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(Constants.indent)
            make.width.equalTo(Constants.FavoriteButton.width)
            make.right.equalTo(contentView).offset(-Constants.indent)
            make.bottom.equalTo(contentView).offset(-Constants.indent)
        }
    }
}

// MARK: - Private Methods
    
    private extension TrackTableViewCell {
        
        func configureUI() {
            
            trackNameLabel.numberOfLines = Constants.TrackNameLabel.numberOfLines
            trackNameLabel.font = Constants.TrackNameLabel.font
            
            artistNameLabel.numberOfLines = Constants.ArtistNameLabel.numberOfLines
            artistNameLabel.font = Constants.ArtistNameLabel.font
            
            favoriteButton.setImage(Constants.FavoriteButton.image, for: .normal)
            favoriteButton.tintColor = Constants.FavoriteButton.color
            favoriteButton.startAnimatingPressActions()
            
            stackView.axis = .vertical
            stackView.spacing = Constants.indent
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
        }
        
        func addTargets() {
            favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        }
    }

// MARK: - @Objc Private Methods

@objc
private extension TrackTableViewCell {
    
    func favoriteButtonPressed(sender: UIButton!) {
        
        if favoriteButton.image(for: .normal) == UIImage(systemName: "heart", withConfiguration: Constants.FavoriteButton.largeConfig) {
            realmManager.addToFavourites(track: track)
            favoriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: Constants.FavoriteButton.largeConfig), for: .normal)
        } else {
            realmManager.deleteFromFavourites(track: track)
            favoriteButton.setImage(UIImage(systemName: "heart", withConfiguration: Constants.FavoriteButton.largeConfig), for: .normal)
        }
    }
}
