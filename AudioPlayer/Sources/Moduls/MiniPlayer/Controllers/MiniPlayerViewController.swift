import UIKit
import SnapKit
import AVFoundation

protocol MiniPlayerDelegate {
    func presentPlayerVC()
    func hidePlayerView()
}

class MiniPlayerViewController: BaseViewController<MiniPlayerView> {
    
    var delegate: MiniPlayerDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
        addTargets()
        setupAudioPlayerDelegate()
        checkCurrentTrack()
    }
}

//MARK: - ChangeTrackDelegate

extension MiniPlayerViewController : ChangeTrackDelegate {
    
    func nextTrackDelegate() {
        print("Выполнена анимация делегата смахивание трека вправо.")
        makeRightAnimation()
    }
    
    func playPauseActionDelegate() {
        print("Пауза.Стоп делегата .")
        playPauseAction()
    }
    
    func previousTrackDelegate() {
        print("Выполнена анимация делегата смахивание трека влево.")
        makeLeftAnimation()
    }
}

// MARK: - Actions

@objc
private extension MiniPlayerViewController {
    
    //MARK: - Gesture Actions
    
    @objc func tapDetected() {
        guard let delegate = delegate else { return }
        delegate.presentPlayerVC()
    }
    
    @objc private func didSwipeUp(_ sender: UISwipeGestureRecognizer) {
        guard let delegate = delegate else { return }
        delegate.presentPlayerVC()
    }
    
    @objc private func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            AudioPlayer.mainPlayer.previousTrack()
        }
        makeLeftAnimation()
        print("Previos track")
    }
    
    @objc private func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            AudioPlayer.mainPlayer.nextTrack()
        }
        makeRightAnimation()
        print("Next track")
    }
    
    // MARK: - Buttons Actions
    
    @objc func playPauseAction() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        if AudioPlayer.mainPlayer.playStatus == .paused {
            AudioPlayer.mainPlayer.playTrack()
            selfView.pauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        } else {
            AudioPlayer.mainPlayer.pauseTrack()
            selfView.pauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: largeConfig), for: .normal)
        }
    }
}

//MARK: - Main Player Delegate

extension MiniPlayerViewController: MiniAudioPlayerDelegate {
    
    func setupAudioPlayerDelegate() {
        AudioPlayer.mainPlayer.miniDelegate = self
        print("MINI-PLAYER DELEGAT SETUP")
    }
    
    func trackPlay(track: TrackModel) {
        self.configure(track)
    }
}

// MARK: - Private Methods

private extension MiniPlayerViewController {
    
    func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL {
            selfView.trackImageView.downloadedFrom(link: coverURL)
        }
        selfView.trackNameLabel.text = track.trackName
        selfView.artistNameLabel.text = track.artistName
    }
    
    func addTargets() {
        selfView.pauseButton.addTarget(self, action: #selector(self.playPauseAction), for: .touchUpInside)
    }
    
    func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        let swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp(_:)))
        swipeGestureRecognizerUp.direction = .up
        view.addGestureRecognizer(swipeGestureRecognizerUp)
        
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(_:)))
        swipeGestureRecognizerLeft.direction = .left
        view.addGestureRecognizer(swipeGestureRecognizerLeft)
        
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight(_:)))
        swipeGestureRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    func playTrack(previewURL: String?) {
        guard let url = URL(string: previewURL ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        
        selfView.player.replaceCurrentItem(with: playerItem)
        selfView.player.play()
    }
    
    func checkCurrentTrack() {
        if let track = AudioPlayer.mainPlayer.currentTrack {
            self.configure(track)
        }
    }
    
    func makeLeftAnimation() {
        var frame = selfView.labelStackView.frame
            UIView.animate(withDuration: 0.6) {
                self.selfView.labelStackView.alpha = 0.1
            }
            frame.origin.x -= 400
            UIView.animate(withDuration: 0.6) {
                self.selfView.labelStackView.frame = frame
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                selfView.labelStackView.alpha = 1
                selfView.labelStackView.frame.origin.x += 400
            }
    }
    
    func makeRightAnimation() {
        var frame = selfView.labelStackView.frame
       
            frame.origin.x += 400
            UIView.animate(withDuration: 0.6) {
                self.selfView.labelStackView.alpha = 0.1
                self.selfView.labelStackView.frame = frame
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                selfView.labelStackView.alpha = 1
                selfView.labelStackView.frame.origin.x -= 400
            }
        }
    }

