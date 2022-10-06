import UIKit
import SnapKit
import AVFoundation

class MiniPlayerView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let cornerRadius: CGFloat = 16
        
        enum TrackImageView {
            static let image = UIImage(named: "test")
            static let cornerRadius: CGFloat = 25
            static let top: CGFloat = 10
            static let leading: CGFloat = 18
            static let size: CGFloat = 50
        }
        
        enum LabelStackView {
            static let top: CGFloat = 16
            static let leading: CGFloat = 70
        }
        
        enum ControllersStackView {
            static let spacing: CGFloat = 5
            static let top: CGFloat = 25
            static let trealing: CGFloat = -16
        }
        
        enum TrackNameLabel {
            static let text = "Track Name"
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
        
        enum ArtistNameLabel {
            static let text = "Artist Name"
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 14, weight: .light)
        }
        
        enum LeftButton {
            static let pointSize: CGFloat = 10
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.LeftButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "backward.end.alt.fill", withConfiguration: Constants.LeftButton.largeConfig)
        }
        
        enum RightButton {
            static let pointSize: CGFloat = 10
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.RightButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "forward.end.alt.fill", withConfiguration: Constants.RightButton.largeConfig)
        }
        
        enum PauseButton {
            static let pointSize: CGFloat = 15
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.PauseButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "pause.fill", withConfiguration: Constants.PauseButton.largeConfig)
        }
    }
    
    // MARK: - UI Elements
    
    let player = AVPlayer()
    
    lazy var labelStackView = UIStackView()
    lazy var сontrollersStackView = UIStackView()
    
    lazy var trackImageView = UIImageView()
    
    lazy var trackNameLabel = UILabel()
    lazy var artistNameLabel = UILabel()
    
    lazy var leftBackwardButton = UIButton()
    lazy var rightBackwardButton = UIButton()
    lazy var pauseButton = UIButton()
    
    // MARK: - Initilization
    
    override func configure() {
        configureUI()
        configureConstraints()
    }
}

// MARK: - Private Methods

private extension MiniPlayerView {
    
    func configureUI() {
        backgroundColor = UIColor.anotherWhite
        layer.cornerRadius = Constants.cornerRadius
        
        player.automaticallyWaitsToMinimizeStalling = false
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.alignment = .fill
        
        сontrollersStackView.axis = .horizontal
        сontrollersStackView.alignment = .center
        сontrollersStackView.spacing = Constants.ControllersStackView.spacing
        сontrollersStackView.distribution = .fillEqually
        
        trackImageView.contentMode = .scaleAspectFit
        trackImageView.image = Constants.TrackImageView.image
        trackImageView.layer.cornerRadius = Constants.TrackImageView.cornerRadius
        trackImageView.layer.masksToBounds = true
        
        trackNameLabel.text = Constants.TrackNameLabel.text
        trackNameLabel.numberOfLines = Constants.TrackNameLabel.numberOfLines
        trackNameLabel.font = Constants.TrackNameLabel.font
        
        artistNameLabel.text = Constants.ArtistNameLabel.text
        artistNameLabel.numberOfLines = Constants.ArtistNameLabel.numberOfLines
        artistNameLabel.font = Constants.ArtistNameLabel.font
        
        leftBackwardButton.setImage(Constants.LeftButton.image, for: .normal)
        leftBackwardButton.tintColor = .black
        leftBackwardButton.startAnimatingPressActions()
        
        rightBackwardButton.setImage(Constants.RightButton.image, for: .normal)
        rightBackwardButton.tintColor = .black
        rightBackwardButton.startAnimatingPressActions()
        
        pauseButton.setImage(Constants.PauseButton.image, for: .normal)
        pauseButton.tintColor = .black
        pauseButton.startAnimatingPressActions()
    }
    
    func configureConstraints() {
        addSubview(trackImageView)
        trackImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.TrackImageView.top)
            make.leading.equalTo(snp.leading).offset(Constants.TrackImageView.leading)
            make.size.height.equalTo(Constants.TrackImageView.size)
            make.size.width.equalTo(Constants.TrackImageView.size)
        }
        
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(trackNameLabel)
        labelStackView.addArrangedSubview(artistNameLabel)
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.LabelStackView.top)
            make.leading.equalTo(trackImageView.snp.leading).inset(Constants.LabelStackView.leading)
        }
        
        addSubview(сontrollersStackView)
        сontrollersStackView.addArrangedSubview(leftBackwardButton)
        сontrollersStackView.addArrangedSubview(pauseButton)
        сontrollersStackView.addArrangedSubview(rightBackwardButton)
        сontrollersStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.ControllersStackView.top)
            make.trailing.equalTo(snp.trailing).offset(Constants.ControllersStackView.trealing)
        }
    }
}
