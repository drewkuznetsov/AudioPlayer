//
//  MiniPlayerViewController.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 27.09.2022.
//

import UIKit
import SnapKit
import SwiftUI

protocol MiniPlayerDelegate {
    func presentPlayerView()
}

class MiniPlayerViewController: UIViewController {
    // Делегат позволяющий вернуть мини-плэер на тап-бар после дис-мисса.
    var delegate: MiniPlayerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainWhite
        configureUI()
        setupConstraints()
        // add a tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
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
    private let artistNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Artist Name"
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 14, weight: .light)
        return view
    }()
    
    
    //Создаем кнопки управления треками для воспроизведения музыки.
    ///Создаем кнопку предыдущего трека.
    private lazy var leftBackwardButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        leftButton.tintColor = .black
        leftButton.addTarget(self, action: #selector(self.previousTrack), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        return leftButton
    } ()
    ///Создаем кнопку предыдущего трека.
    private lazy var rightBackwardButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        rightButton.configuration?.buttonSize = .large
        rightButton.configuration?.imagePadding = 25
        rightButton.tintColor = .black
        rightButton.addTarget(self, action: #selector(self.nextTrack), for: .touchUpInside)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        return rightButton
    } ()
    ///Создаем кнопку приостановки / плэя трека.
    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        pauseButton.tintColor = .black
        pauseButton.addTarget(self, action: #selector(self.playPauseAction), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
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
    ///Laylout
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
            make.top.equalTo(view.snp.top).offset(16)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
    
    func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL {
            trackImageView.downloadedFrom(link: coverURL)
        }
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
    
    //MARK: - Objc func
    
    ///Замечает тап по контейнер-вью и показывает детальное представление трека.
    @objc func tapDetected() {
        // 3
        guard let delegate = delegate else { return }
        delegate.presentPlayerView()
    }
    
    ///Замечает тап по кнопке плэй.
    @objc func playPauseAction() {
        
    }
    ///Замечает тап по кнопке предыдущего трека.
    @objc func previousTrack() {
        
    }
    ///Замечает тап по кнопке следующего трека..
    @objc func nextTrack() {
        
    }
}
