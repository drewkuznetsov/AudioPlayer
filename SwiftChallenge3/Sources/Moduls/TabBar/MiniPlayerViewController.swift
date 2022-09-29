//
//  MiniPlayerViewController.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 27.09.2022.
//

import UIKit
import SnapKit
import SwiftUI
import AVFoundation

protocol MiniPlayerDelegate {
    func presentPlayerVC()
    func hidePlayerView()
}

class MiniPlayerViewController: UIViewController {
    // Делегат позволяющий вернуть мини-плэер на тап-бар после дис-мисса.
    var delegate: MiniPlayerDelegate?
    //Player аналогичный в PlayerVC.
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.anotherWhite
        view.layer.cornerRadius = 16
        //setup Views
        configureUI()
        setupConstraints()
        // add a tap gesture
        setupGestureRecognizers()
        
        
    }
    
    //MARK: - Private LazyVar
    // создаем стек для управления воспроизведением трека
    private lazy var labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // создаем стек для управления воспроизведением трека
    private lazy var сontrollersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    ///Создаем вью картинки трека.
    private lazy var trackImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "test")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///Создаем лейбл названия трека.
    private lazy var trackNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Track Name"
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    ///Создаем лейбл имени артиста трека.
    private lazy var artistNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Artist Name"
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 14, weight: .light)
        return view
    }()
    
    
    //Создаем кнопки управления треками для воспроизведения музыки.
    ///Создаем кнопку предыдущего трека.
    private lazy var leftBackwardButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold, scale: .large)
        let leftButton = UIButton()
        leftButton.setImage(UIImage(systemName: "backward.end.alt.fill", withConfiguration: largeConfig), for: .normal)
        leftButton.tintColor = .black
        leftButton.startAnimatingPressActions()
        leftButton.addTarget(self, action: #selector(self.previousTrack), for: .touchUpInside)
        return leftButton
    } ()
    ///Создаем кнопку предыдущего трека.
    private lazy var rightBackwardButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold, scale: .large)
        let rightButton = UIButton()
        rightButton.setImage(UIImage(systemName: "forward.end.alt.fill", withConfiguration: largeConfig), for: .normal)
        rightButton.tintColor = .black
        rightButton.startAnimatingPressActions()
        rightButton.addTarget(self, action: #selector(self.nextTrack), for: .touchUpInside)
        return rightButton
    } ()
    ///Создаем кнопку приостановки / плэя трека.
    private lazy var pauseButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        pauseButton.tintColor = .black
        pauseButton.startAnimatingPressActions()
        pauseButton.addTarget(self, action: #selector(self.playPauseAction), for: .touchUpInside)
        return pauseButton
    } ()
    
    //MARK: - Private func
    ///Setup View and stack
    private func configureUI() {
        view.addSubview(trackImageView)
        
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(trackNameLabel)
        labelStackView.addArrangedSubview(artistNameLabel)
        
        
        view.addSubview(сontrollersStackView)
        сontrollersStackView.addArrangedSubview(leftBackwardButton)
        сontrollersStackView.addArrangedSubview(pauseButton)
        сontrollersStackView.addArrangedSubview(rightBackwardButton)
    }
    ///Laylout, констрейны.
    private func setupConstraints() {
        trackImageView.layer.cornerRadius = 25
        trackImageView.layer.masksToBounds = true
        
        trackImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(18)
            make.size.height.equalTo(50)
            make.size.width.equalTo(50)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(16)
            make.leading.equalTo(trackImageView.snp.leading).inset(70)
        }
        
        сontrollersStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
    ///Установка жестов.
    private func setupGestureRecognizers() {
        //Тап по Вью.
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        //Верхний свайп
        let swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp(_:)))
        swipeGestureRecognizerUp.direction = .up
        view.addGestureRecognizer(swipeGestureRecognizerUp)
        //Левый свайп
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(_:)))
        swipeGestureRecognizerLeft.direction = .left
        view.addGestureRecognizer(swipeGestureRecognizerLeft)
        //Правый свайп
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight(_:)))
        swipeGestureRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL {
            trackImageView.downloadedFrom(link: coverURL)
        }
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
    
    private func playTrack(previewURL: String?) {
        guard let url = URL(string: previewURL ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    ///Анимация свайпа трека в левую сторону.
    func makeLeftAnimation() {
        var frame = labelStackView.frame
        UIView.animate(withDuration: 0.25) {
            self.labelStackView.alpha = 0.1
        }
        frame.origin.x -= 400
        UIView.animate(withDuration: 0.6) {
            
            self.labelStackView.frame = frame
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            labelStackView.alpha = 1
            labelStackView.frame.origin.x += 400
        }
    }
    ///Анимация свайпа трека в правую сторону.
    func makeRightAnimation() {
        var frame = labelStackView.frame
        frame.origin.x += 400
        UIView.animate(withDuration: 0.6) {
            self.labelStackView.alpha = 0.1
            self.labelStackView.frame = frame
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            labelStackView.alpha = 1
            labelStackView.frame.origin.x -= 400
        }
    }
    
    //MARK: - Objc Gesture Methods
    ///Замечает тап по контейнер-вью и показывает детальное представление трека.
    @objc func tapDetected() {
        // 3
        guard let delegate = delegate else { return }
        delegate.presentPlayerVC()
    }
    
    @objc private func didSwipeUp(_ sender: UISwipeGestureRecognizer) {
        guard let delegate = delegate else { return }
        delegate.presentPlayerVC()
    }
    ///Свайп вклчающий следующий трек.
    @objc private func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        makeLeftAnimation()
    }
    ///Свайп вклчающий предыдущий трек.
    @objc private func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        makeRightAnimation()
    }
    
    
    //MARK: - Objc Buttons Methods
    ///Замечает тап по кнопке плэй.
    @objc func playPauseAction() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        if player.timeControlStatus == .paused {
            player.play()
            pauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        } else {
            player.pause()
            pauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: largeConfig), for: .normal)
        }
    }
    ///Кнопка. Замечает тап по кнопке предыдущего трека.
    @objc func previousTrack() {
        print("left animation")
        makeLeftAnimation()
    }
    ///Кнопка. Замечает тап по кнопке следующего трека.
    @objc func nextTrack() {
        print("right animation")
        makeRightAnimation()
    }
}

extension MiniPlayerViewController : ChangeTrackDelegate {
    func nextTrackD() {
        print("Выполнена анимация делегата смахивание трека вправо.")
        makeRightAnimation()
    }
    
    func playPauseActionD() {
        print("Пауза.Стоп делегата .")
        playPauseAction()
    }
    
    func previousTrackD() {
        print("Выполнена анимация делегата смахивание трека влево.")
        makeLeftAnimation()
    }
    
    
    
    
    
    
}
