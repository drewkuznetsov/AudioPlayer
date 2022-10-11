//
//  PlayerViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit
import AVKit

protocol ChangeTrackDelegate {
    func nextTrackDelegate()
    func playPauseActionDelegate()
    func previousTrackDelegate()
}

class PlayerViewController: UIViewController {
    var delegate : ChangeTrackDelegate?
    //MARK: - View

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cover")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var labelHeartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var heartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var сontrollersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var leftBackwardButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "Left"), for: .normal)
        leftButton.addTarget(self, action: #selector(self.previousTrack), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.startAnimatingPressActions()
        return leftButton
    }()
    
    private lazy var rightBackwardButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "Right"), for: .normal)
        rightButton.addTarget(self, action: #selector(self.nextTrack), for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.startAnimatingPressActions()
        return rightButton
    }()
    
    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        pauseButton.addTarget(self, action: #selector(self.playPauseAction), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.startAnimatingPressActions()
        return pauseButton
    }()

    private lazy var dismissButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
        let dismissButton = UIButton()
        dismissButton.setImage(UIImage(systemName: "chevron.compact.down", withConfiguration: largeConfig), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        dismissButton.tintColor = .systemGray
        dismissButton.isHidden = true
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.startAnimatingPressActions()
        return dismissButton
    }()

    private lazy var sliderTime: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.tabBarItemLight
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private lazy var sliderSound: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.tabBarItemLight
        slider.value = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private lazy var stackTimerView: UIStackView = {
        let stackTimer = UIStackView()
        stackTimer.axis = .vertical
        stackTimer.spacing = 15
        stackTimer.distribution = .fillEqually
        stackTimer.translatesAutoresizingMaskIntoConstraints = false
        return stackTimer
    }()
    

    private lazy var stackSoundView: UIStackView = {
        let stackSound = UIStackView()
        stackSound.axis = .horizontal
        stackSound.spacing = 10
        stackSound.distribution = .fillProportionally
        stackSound.translatesAutoresizingMaskIntoConstraints = false
        return stackSound
    }()
    

    private lazy var stackTime: UIStackView = {
        let stackTime = UIStackView()
        stackTime.axis = .horizontal
        stackTime.distribution = .fillProportionally
        stackTime.translatesAutoresizingMaskIntoConstraints = false
        return stackTime
    }()

    private lazy var leftTimeLabel: UILabel = {
        let labelTime = UILabel()
        labelTime.text = "00:00"
        labelTime.textColor = .black
        labelTime.textAlignment = .left
        labelTime.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        return labelTime
    }()
    
    private lazy var rightTimeLabel: UILabel = {
        let labelTime = UILabel()
        labelTime.text = "--:--"
        labelTime.textColor = .black
        labelTime.textAlignment = .right
        labelTime.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        return labelTime
    }()

    private lazy var nameAuthorLabel: UILabel = {
        let labelArtist = UILabel()
        labelArtist.text = "Author"
        labelArtist.textColor = .systemPink
        labelArtist.font = UIFont.systemFont(ofSize: 24, weight: .light)
        labelArtist.numberOfLines = 0
        labelArtist.translatesAutoresizingMaskIntoConstraints = false
        return labelArtist
    }()

    private lazy var nameTrackLabel: UILabel = {
        let labelTrack = UILabel()
        labelTrack.text = "Track title"
        labelTrack.textColor = .black
        labelTrack.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        labelTrack.numberOfLines = 0
        labelTrack.translatesAutoresizingMaskIntoConstraints = false
        return labelTrack
    }()

    private lazy var soundMinImage: UIImageView = {
        let soundMin = UIImageView()
        soundMin.image = UIImage(named: "min")
        soundMin.translatesAutoresizingMaskIntoConstraints = false
        return soundMin
    }()
    

    private lazy var soundMaxImage: UIImageView = {
        let soundMax = UIImageView()
        soundMax.image = UIImage(named: "max")
        soundMax.translatesAutoresizingMaskIntoConstraints = false
        return soundMax
    }()
    
    private lazy var addFavoritBarButton: UIButton = {
        let setConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart", withConfiguration: setConfig), for: .normal)
        button.addTarget(self,  action: #selector(buttonTapped), for: .touchUpInside)
        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupGestureRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let scale: CGFloat = 0.9
        trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        trackImageView.layer.cornerRadius = 5
    }

    public func showDismissButton() {
        dismissButton.isHidden = false
    }
    
    private func setupView() {
        view.addSubview(trackImageView)
        view.addSubview(stackView)
        view.addSubview(dismissButton)
        view.addSubview(sliderTime)
        stackView.addArrangedSubview(stackTimerView)
        stackView.addArrangedSubview(labelHeartStackView)
        stackTimerView.addArrangedSubview(stackTime)
        stackTime.addArrangedSubview(leftTimeLabel)
        stackTime.addArrangedSubview(rightTimeLabel)
        labelHeartStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(nameTrackLabel)
        labelStackView.addArrangedSubview(nameAuthorLabel)
        labelHeartStackView.addArrangedSubview(heartStackView)
        heartStackView.addArrangedSubview(addFavoritBarButton)
        stackView.addArrangedSubview(сontrollersStackView)
        сontrollersStackView.addArrangedSubview(leftBackwardButton)
        сontrollersStackView.addArrangedSubview(pauseButton)
        сontrollersStackView.addArrangedSubview(rightBackwardButton)
        stackView.addArrangedSubview(stackSoundView)
        stackSoundView.addArrangedSubview(soundMinImage)
        stackSoundView.addArrangedSubview(sliderSound)
        stackSoundView.addArrangedSubview(soundMaxImage)
        setupConstraintsActivate()
    }
    
    private func setupConstraintsActivate() {
        NSLayoutConstraint.activate([
            self.dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
            self.dismissButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            
            self.trackImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.trackImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.trackImageView.heightAnchor.constraint(equalToConstant: 250),
            self.trackImageView.widthAnchor.constraint(equalToConstant: 250),

            self.sliderTime.topAnchor.constraint(equalTo: self.trackImageView.bottomAnchor, constant: 30),
            self.sliderTime.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.sliderTime.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            self.sliderTime.heightAnchor.constraint(equalToConstant: 15),

            self.stackView.topAnchor.constraint(equalTo: self.sliderTime.bottomAnchor, constant: 5),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120),

            self.stackTimerView.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            self.stackTimerView.heightAnchor.constraint(equalToConstant: 20),

            self.labelHeartStackView.topAnchor.constraint(equalTo: self.stackTimerView.bottomAnchor),
            self.nameTrackLabel.heightAnchor.constraint(equalToConstant: 20),
            self.nameAuthorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.сontrollersStackView.topAnchor.constraint(equalTo: self.labelHeartStackView.bottomAnchor),

            self.soundMinImage.heightAnchor.constraint(equalToConstant: 17),
            self.soundMinImage.widthAnchor.constraint(equalToConstant: 17),
            self.soundMaxImage.heightAnchor.constraint(equalToConstant: 17),
            self.soundMaxImage.widthAnchor.constraint(equalToConstant: 17),

            self.labelStackView.leadingAnchor.constraint(equalTo: self.labelHeartStackView.leadingAnchor, constant: 32),
            self.heartStackView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }

    private func setupGestureRecognizer() {
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(_:)))
        swipeGestureRecognizerDown.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizerDown)
    }
    

    //MARK: - Navigation
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    private func playTrack(previewURL: String?) {
        guard let url = URL(string: previewURL ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    //MARK: - Animations

    private func enLargeTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {self.trackImageView.transform = .identity } , completion: nil)
    }

    private func reduceTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {let scale: CGFloat = 0.9
            self.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale) } , completion: nil)

    }

    //TODO: - Делегат
    @objc func buttonTapped(sender: UIButton) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
        if addFavoritBarButton.image(for: .normal) == UIImage(systemName: "heart", withConfiguration: largeConfig) {
            addFavoritBarButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: largeConfig), for: .normal)

        } else {
            addFavoritBarButton.setImage(UIImage(systemName: "heart", withConfiguration: largeConfig), for: .normal)
        }
    }

    @objc func playPauseAction(_ sender: Any) {
        delegate?.playPauseActionDelegate()
        if player.timeControlStatus == .paused {
            player.play()
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
            enLargeTrackImageView()
        } else {
            player.pause()
            pauseButton.setImage(UIImage(named: "play"), for: .normal)
            reduceTrackImageView()
        }
    }

    @objc func previousTrack() {
        delegate?.previousTrackDelegate()
    }
    
    @objc func nextTrack() {
        delegate?.nextTrackDelegate()
    }

    @objc private func didSwipeDown(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true)
    }

    @objc func dismissButtonTapped() {
        print("Dismiss Button Pressed")
        self.dismiss(animated: true)
    }
    
}
