//
//  TrackView.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 26.09.2022.
//

import UIKit
import SnapKit

class TrackView: UIView {
    //MARK: - Private Let / Var
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    ///Создаем лейбл названия трека.
    private lazy var trackNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    ///Создаем лейбл имени артиста трека.
    private let artistNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 14, weight: .light)
        return view
    }()
    
    
    //Создаем кнопки управления треками для воспроизведения музыки.
    ///Создаем кнопку предыдущего трека.
    private lazy var leftBackwardButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "Left"), for: .normal)
        leftButton.addTarget(self, action: #selector(self.previousTrack), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        return leftButton
    } ()
    ///Создаем кнопку предыдущего трека.
    private lazy var rightBackwardButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "Right"), for: .normal)
        rightButton.addTarget(self, action: #selector(self.nextTrack), for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        return rightButton
    } ()
    ///Создаем кнопку приостановки / плэя трека.
    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(named: "pause1"), for: .normal)
        pauseButton.addTarget(self, action: #selector(self.playPauseAction), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        return pauseButton
    } ()
    
    //MARK: - Lifecycle init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.mainWhite
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        trackImageView.layer.cornerRadius = 70 / 2
        trackImageView.layer.masksToBounds = true
        
        trackImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.size.height.equalTo(50)
            make.size.width.equalTo(50)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(trackImageView.snp.top).offset(25)
            make.leading.equalTo(trackImageView.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-25)
        }
        сontrollersStackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    //MARK: - Private func
    private func configureUI() {
        addSubview(trackImageView)
        
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(trackNameLabel)
        labelStackView.addArrangedSubview(artistNameLabel)
        
        
        addSubview(сontrollersStackView)
        сontrollersStackView.addArrangedSubview(leftBackwardButton)
        сontrollersStackView.addArrangedSubview(pauseButton)
        сontrollersStackView.addArrangedSubview(rightBackwardButton)
    }
    
    func configure(_ track: TrackModel) {
        if let coverURL = track.coverURL {
            trackImageView.downloadedFrom(link: coverURL)
        }
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
    
    //MARK: - Objc func
    
    @objc func playPauseAction() {
        
    }
    
    @objc func previousTrack() {
        
    }
    
    @objc func nextTrack() {
        
    }
}













