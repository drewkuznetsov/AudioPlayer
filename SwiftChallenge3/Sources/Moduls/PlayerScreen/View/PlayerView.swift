import UIKit
import SnapKit
import AVFoundation

class PlayerView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let spacing : CGFloat = 5
        static let indent : CGFloat = 16
        
        enum StackView {
            static let indent : CGFloat = 16
            static let leading : CGFloat = 70
            static let bottom  : CGFloat = -120
        }
        
        enum LabelHeartStackView {
            static let leading : CGFloat = 32
        }
        enum HeartStackView {
            static let width : CGFloat = 35
        }
        enum LabelStackView {
            static let leading : CGFloat = 32
        }
        
        enum ControllersStackView {
            static let spacing : CGFloat = 5
        }
        
        enum StackSoundView {
            static let spacing : CGFloat = 10
            static let top : CGFloat = 25
            static let trealing : CGFloat = -16
        }
        
        enum StackTimeLabels {
            static let top : CGFloat = 25
            static let trealing : CGFloat = -16
        }
        
        enum StackTimerView {
            static let height : CGFloat = 20
            static let spacing : CGFloat = 45
        }
        
        enum LeftButton {
            static let pointSize : CGFloat = 18
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.LeftButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "backward.end.alt.fill", withConfiguration: Constants.LeftButton.largeConfig)
        }
        
        enum RightButton {
            static let pointSize : CGFloat = 18
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.RightButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "forward.end.alt.fill", withConfiguration: Constants.RightButton.largeConfig)
        }
        
        enum PauseButton {
            static let pointSize : CGFloat = 28
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.PauseButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "pause.fill", withConfiguration: Constants.PauseButton.largeConfig)
        }
        
        enum DismissButton {
            static let top : CGFloat = 45
            static let trailing : CGFloat = 60
            static let pointSize : CGFloat = 22
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.DismissButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "chevron.compact.down", withConfiguration: Constants.DismissButton.largeConfig)
            static let color = UIColor.systemGray
        }
        
        enum AddFavoriteButton {
            static let pointSize : CGFloat = 22
            static let largeConfig = UIImage.SymbolConfiguration(pointSize: Constants.AddFavoriteButton.pointSize, weight: .bold, scale: .large)
            static let image = UIImage(systemName: "heart", withConfiguration: Constants.AddFavoriteButton.largeConfig) 
            static let color = UIColor.systemPink
        }
        
        enum SliderTime {
            static let color = UIColor.tabBarItemLight
            static let value : Float = 0
            static let bot : CGFloat = 30
            static let height : CGFloat = 16
        }
        
        enum SliderSound {
            static let color = UIColor.tabBarItemLight
            static let value : Float = 1
        }

        enum LeftTimeLabel {
            static let text = "00:00"
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        enum RightTimeLabel {
            static let text = "--:--"
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        enum AuthorNameLabel {
            static let text = "Author"
            static let numberOfLines = 1
            static let font = UIFont.systemFont(ofSize: 24, weight: .light)
            static let height : CGFloat = 20
            static let color = UIColor.systemPink
        }
        
        enum TrackNameLabel {
            static let text = "Track title"
            static let numberOfLines = 0
            static let font = UIFont.systemFont(ofSize: 24, weight: .semibold)
            static let height : CGFloat = 20
            
        }
        
        enum TrackImageView {
            static let image = UIImage(systemName: "person.crop.circle.badge.questionmark.fill")
            static let top: CGFloat = 130
            static let height: CGFloat = 250
            static let widht: CGFloat = 250
        }
        
        enum SoundMinimumImage {
            static let image = UIImage(named: "min")
            static let height : CGFloat = 14
            static let width : CGFloat = 14
        }
        
        enum SoundMaximumImage {
            static let image = UIImage(named: "max")
            static let height : CGFloat = 25
            static let width : CGFloat = 25
        }
    }
    
    // MARK: - UI Elements
    
    let player = AVPlayer()
    
    lazy var stackView = UIStackView()
    lazy var labelHeartStackView = UIStackView()
    lazy var heartStackView = UIStackView()
    lazy var labelStackView = UIStackView()
    lazy var controllersStackView = UIStackView()
    lazy var stackTimerView = UIStackView()
    lazy var stackSoundView = UIStackView()
    lazy var stackTime = UIStackView()
    
    lazy var leftBackwardButton = UIButton()
    lazy var rightBackwardButton = UIButton()
    lazy var pauseButton = UIButton()
    lazy var addFavoriteButton = UIButton()
    lazy var dismissButton = UIButton()
    
    lazy var sliderTime = UISlider()
    lazy var sliderSound = UISlider()
    
    lazy var trackImageView = UIImageView()
    lazy var soundMinimimImage = UIImageView()
    lazy var soundMaximumImage = UIImageView()
    
    lazy var trackNameLabel = UILabel()
    lazy var authorNameLabel = UILabel()
    lazy var rightTimeLabel = UILabel()
    lazy var leftTimeLabel = UILabel()
    
    
    // MARK: - Initilization
    
    override func configure() {
        configureUI()
        configureConstraints()
    }
}

// MARK: - Private Methods

private extension PlayerView {
    
    func configureUI() {
        
        player.automaticallyWaitsToMinimizeStalling = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        labelHeartStackView.axis = .horizontal
        labelHeartStackView.distribution = .fillProportionally
        labelHeartStackView.alignment = .center
        labelHeartStackView.spacing = Constants.spacing
        
        heartStackView.axis = .vertical
        heartStackView.distribution = .fillProportionally
        heartStackView.alignment = .trailing
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        labelStackView.alignment = .center
        labelStackView.spacing = Constants.spacing
        
        stackTime.axis = .horizontal
        stackTime.distribution = .fillProportionally
        
        stackTimerView.axis = .vertical
        stackTimerView.spacing = Constants.StackTimerView.spacing
        stackTimerView.distribution = .fillEqually
        
        controllersStackView.axis = .horizontal
        controllersStackView.alignment = .center
        controllersStackView.spacing = Constants.spacing
        controllersStackView.distribution = .fillEqually
        
        stackSoundView.spacing = Constants.StackSoundView.spacing
        stackSoundView.axis = .horizontal
        stackSoundView.distribution = .fillProportionally
        
        leftBackwardButton.setImage(Constants.LeftButton.image, for: .normal)
        leftBackwardButton.tintColor = .black
        leftBackwardButton.startAnimatingPressActions()
        
        rightBackwardButton.setImage(Constants.RightButton.image, for: .normal)
        rightBackwardButton.tintColor = .black
        rightBackwardButton.startAnimatingPressActions()
        
        pauseButton.setImage(Constants.PauseButton.image, for: .normal)
        pauseButton.tintColor = .black
        pauseButton.startAnimatingPressActions()
        
        addFavoriteButton.setImage(Constants.AddFavoriteButton.image, for: .normal)
        addFavoriteButton.tintColor = Constants.AddFavoriteButton.color
        addFavoriteButton.startAnimatingPressActions()
        
        dismissButton.setImage(Constants.DismissButton.image, for: .normal)
        dismissButton.tintColor = Constants.DismissButton.color
        dismissButton.startAnimatingPressActions()
        
        sliderTime.tintColor = Constants.SliderTime.color
        sliderTime.value = Constants.SliderTime.value
        sliderSound.tintColor = Constants.SliderSound.color
        sliderSound.value = Constants.SliderSound.value
        
        trackImageView.contentMode = .scaleAspectFit
        trackImageView.image = Constants.TrackImageView.image
        trackImageView.clipsToBounds = true
        trackImageView.tintColor = UIColor.tabBarItemLight
        
        soundMinimimImage.image = Constants.SoundMinimumImage.image
        soundMaximumImage.image = Constants.SoundMaximumImage.image
        soundMaximumImage.contentMode = .scaleAspectFit
        soundMinimimImage.contentMode = .scaleAspectFit
        
        trackNameLabel.text = Constants.TrackNameLabel.text
        trackNameLabel.numberOfLines = Constants.TrackNameLabel.numberOfLines
        trackNameLabel.font = Constants.TrackNameLabel.font
        
        authorNameLabel.text = Constants.AuthorNameLabel.text
        authorNameLabel.numberOfLines = Constants.AuthorNameLabel.numberOfLines
        authorNameLabel.font = Constants.AuthorNameLabel.font
        authorNameLabel.textColor = Constants.AuthorNameLabel.color
        
        trackNameLabel.text = Constants.TrackNameLabel.text
        trackNameLabel.numberOfLines = Constants.TrackNameLabel.numberOfLines
        trackNameLabel.font = Constants.TrackNameLabel.font

        leftTimeLabel.text = Constants.LeftTimeLabel.text
        leftTimeLabel.numberOfLines = Constants.LeftTimeLabel.numberOfLines
        leftTimeLabel.font = Constants.LeftTimeLabel.font
        leftTimeLabel.textAlignment = .left
        
        rightTimeLabel.text = Constants.RightTimeLabel.text
        rightTimeLabel.numberOfLines = Constants.RightTimeLabel.numberOfLines
        rightTimeLabel.font = Constants.RightTimeLabel.font
        rightTimeLabel.textAlignment = .right
    }
    
    private func configureConstraints() {
        
        addSubview(stackView)
        addSubview(dismissButton)
        addSubview(sliderTime)
        addSubview(trackImageView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(sliderTime.snp.bottom).offset(Constants.spacing)
            make.trailing.equalTo(snp.trailing).offset(-Constants.indent)
            make.leading.equalTo(snp.leading).offset(Constants.indent)
            make.bottom.equalTo(snp.bottom).offset(Constants.StackView.bottom)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.DismissButton.top)
            make.trailing.equalTo(snp.leading).offset(Constants.DismissButton.trailing)
        }
        
        sliderTime.snp.makeConstraints { make in
            make.top.equalTo(trackImageView.snp.bottom).offset(Constants.SliderTime.bot)
            make.leading.equalTo(snp.leading).offset(Constants.indent)
            make.trailing.equalTo(snp.trailing).offset(-Constants.indent)
            make.height.equalTo(Constants.SliderTime.height)
        }
        
        trackImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(Constants.TrackImageView.top)
            make.height.equalTo(Constants.TrackImageView.height)
            make.width.equalTo(Constants.TrackImageView.widht)
            make.centerX.equalTo(snp.centerX)
        }
        
        stackView.addArrangedSubview(stackTimerView)
        
        stackTimerView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top)
            make.height.equalTo(Constants.StackTimerView.height)
        }
        
        stackView.addArrangedSubview(labelHeartStackView)
        
        labelHeartStackView.snp.makeConstraints { make in
            make.top.equalTo(stackTimerView.snp.bottom)
        }
        
        stackTimerView.addArrangedSubview(stackTime)
        stackTime.addArrangedSubview(leftTimeLabel)
        stackTime.addArrangedSubview(rightTimeLabel)
        
        labelHeartStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(trackNameLabel)
        labelStackView.addArrangedSubview(authorNameLabel)
        labelHeartStackView.addArrangedSubview(heartStackView)
        heartStackView.addArrangedSubview(addFavoriteButton)
        
        trackNameLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.TrackNameLabel.height)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.AuthorNameLabel.height)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(labelHeartStackView.snp.leading).offset(Constants.LabelStackView.leading)
        }
        
        heartStackView.snp.makeConstraints { make in
            make.width.equalTo(Constants.HeartStackView.width)
        }
        
        stackView.addArrangedSubview(controllersStackView)
        controllersStackView.addArrangedSubview(leftBackwardButton)
        controllersStackView.addArrangedSubview(pauseButton)
        controllersStackView.addArrangedSubview(rightBackwardButton)
        
        controllersStackView.snp.makeConstraints { make in
            make.top.equalTo(labelHeartStackView.snp.bottom)
        }
        
        stackView.addArrangedSubview(stackSoundView)
        stackSoundView.addArrangedSubview(soundMinimimImage)
        stackSoundView.addArrangedSubview(sliderSound)
        stackSoundView.addArrangedSubview(soundMaximumImage)
        
        soundMinimimImage.snp.makeConstraints { make in
            make.height.equalTo(Constants.SoundMinimumImage.height)
            make.width.equalTo(Constants.SoundMinimumImage.width)
        }
        
        soundMaximumImage.snp.makeConstraints { make in
            make.height.equalTo(Constants.SoundMaximumImage.height)
            make.width.equalTo(Constants.SoundMaximumImage.width)
        }
    }
}
