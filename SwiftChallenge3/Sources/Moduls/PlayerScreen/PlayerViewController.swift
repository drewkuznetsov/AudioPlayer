import UIKit
import AVFoundation

protocol ChangeTrackDelegate {
    func nextTrackDelegate()
    func playPauseActionDelegate()
    func previousTrackDelegate()
}

class PlayerViewController: BaseViewController<PlayerView>  {
    
    var delegate : ChangeTrackDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupGestureRecognizer()
        setupTarget()
        setupAudioPlayerDelegate()
        checkCurrentTrack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Private Methods

private extension PlayerViewController {
    
    func setupGestureRecognizer() {
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(_:)))
        swipeGestureRecognizerDown.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizerDown)
    }
    
    func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL?.replacingOccurrences(of: "100x100", with: "600x600") {
            selfView.trackImageView.downloadedFrom(link: coverURL)
        }
        selfView.trackNameLabel.text = track.trackName
        selfView.authorNameLabel.text = track.artistName
        selfView.sliderTime.value = AudioPlayer.mainPlayer.timePercent
    }
    
    func playTrack(previewURL: String?) {
        guard let url = URL(string: previewURL ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        selfView.player.replaceCurrentItem(with: playerItem)
        selfView.player.play()
    }
    
    func setupTarget() {
        selfView.addFavoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        selfView.pauseButton.addTarget(self, action: #selector(playPauseAction), for: .touchUpInside)
        selfView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        selfView.leftBackwardButton.addTarget(self, action: #selector(previousTrack), for: .touchUpInside)
        selfView.rightBackwardButton.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        selfView.sliderTime.addTarget(self, action: #selector(timeSliderChanged), for: .valueChanged)
        selfView.sliderSound.addTarget(self, action: #selector(soundSliderChanged), for: .valueChanged)
    }
    
    func enLargeTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.selfView.trackImageView.transform = .identity
        })
    }
    
    func reduceTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {let scale: CGFloat = 0.8
            self.selfView.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale) } , completion: nil)
    }
}

//MARK: - Main Player Delegate

extension PlayerViewController: AudioPlayerDelegate  {
    
    func setupAudioPlayerDelegate() {
        AudioPlayer.mainPlayer.delegate = self
        print("AUDIO PLAYER DELEGAT SETUP")
    }
    
    func trackPlay(track: TrackModel) {
        self.configure(track)
        print("CONFIGURE TRACK")
    }
    
    func timeChaneged() {
        selfView.leftTimeLabel.text = AudioPlayer.mainPlayer.currentTime
        selfView.rightTimeLabel.text = AudioPlayer.mainPlayer.timeLeft
        selfView.sliderTime.value = AudioPlayer.mainPlayer.timePercent
    }
    func checkCurrentTrack() {
        if let track = AudioPlayer.mainPlayer.currentTrack {
            self.configure(track)
        }
    }
    
    
}

// MARK: - Action

@objc
private extension PlayerViewController {
    
    func favoriteButtonTapped(_ sender : UIButton) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
        if sender.image(for: .normal) == UIImage(systemName: "heart", withConfiguration: largeConfig) {
            sender.setImage(UIImage(systemName: "heart.fill", withConfiguration: largeConfig), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "heart", withConfiguration: largeConfig), for: .normal)
        }
    }
    
    func playPauseAction(_ sender: UIButton) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .bold, scale: .large)
        if AudioPlayer.mainPlayer.playStatus == .paused {
            delegate?.playPauseActionDelegate()
            AudioPlayer.mainPlayer.playTrack()
            selfView.player.play()
            enLargeTrackImageView()
            sender.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        } else {
            AudioPlayer.mainPlayer.pauseTrack()
            sender.setImage(UIImage(systemName: "play.fill", withConfiguration: largeConfig), for: .normal)
            reduceTrackImageView()
        }
    }
    
    func previousTrack() {
        AudioPlayer.mainPlayer.previousTrack()
        delegate?.previousTrackDelegate()
        print("Previous track tapped")
    }
    
    func nextTrack() {
        AudioPlayer.mainPlayer.nextTrack()
        delegate?.nextTrackDelegate()
        print("Next track tapped")
    }

    func didSwipeDown(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    func dismissButtonTapped() {
        print("Dismiss Button tapped")
        self.dismiss(animated: true)
    }
    
    func timeSliderChanged() {
        let percent =  selfView.sliderTime.value
        AudioPlayer.mainPlayer.setTrackPosition(percents: percent)
    }
    
    func soundSliderChanged() {
        AudioPlayer.mainPlayer.setPlayerVolume(volume: selfView.sliderSound.value)
    }
}
