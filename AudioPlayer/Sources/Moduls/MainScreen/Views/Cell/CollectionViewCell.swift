import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        enum TrackImageView {

            static let image = UIImage(systemName: "rectangle.stack.badge.person.crop")
            static let color = UIColor.tabBarItemLight
        }
        
        enum TrackNameLabel {
            static let text = "Track Name"
            static let height : CGFloat = 27
            static let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
        
        enum ArtistNameLabel {
            static let text = "Artist Name"
            static let height : CGFloat = 20
            static let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    // MARK: - Identifier
    
    static let reuseIdentifier = String(describing: CollectionViewCell.self)
    
    // MARK: - Playlist
    
    var track : TrackModel! {
        didSet {
            if let coverURL = track.coverURL?.replacingOccurrences(of: "100x100", with: "600x600") {
                trackImageView.downloadedFrom(link: coverURL)
            }
            trackNameLabel.text = track.trackName
            artistNameLabel.text = track.artistName
        }
    }
    
    // MARK: - UI Elements
    
    var trackImageView = UIImageView()
    var trackNameLabel = UILabel()
    var artistNameLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupDefaultView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.trackImageView = UIImageView()
    }
    
    // MARK: - UI
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(self.trackImageView)
        contentView.addSubview(self.trackNameLabel)
        contentView.addSubview(self.artistNameLabel)

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
            make.height.equalTo(Constants.TrackNameLabel.height)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(Constants.ArtistNameLabel.height)
        }
    }
}

// MARK: - Private Methods

private extension CollectionViewCell {

        func setupDefaultView() {
        trackNameLabel.text = Constants.TrackNameLabel.text
        artistNameLabel.text = Constants.ArtistNameLabel.text
        trackImageView.image = Constants.TrackImageView.image
        trackImageView.tintColor = Constants.TrackImageView.color
    }
}

