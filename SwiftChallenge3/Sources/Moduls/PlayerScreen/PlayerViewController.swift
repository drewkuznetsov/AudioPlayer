//
//  PlayerViewController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {

    //MARK: - View
    //создаем стек для всего отображаемого контента
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cover")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()

    // создаем стек для лейблов с названиями (артиста и трека)
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    } ()

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

    //создаем картинки контроллеры для управления

    private lazy var leftBackwardButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "Left"), for: .normal)
        leftButton.addTarget(self, action: #selector(self.previousTrack), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.startAnimatingPressActions()
        return leftButton
    } ()

    private lazy var rightBackwardButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "Right"), for: .normal)
        rightButton.addTarget(self, action: #selector(self.nextTrack), for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.startAnimatingPressActions()
        return rightButton
    } ()

    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(named: "pause1"), for: .normal)
        pauseButton.addTarget(self, action: #selector(self.playPauseAction), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.startAnimatingPressActions()

        return pauseButton
    } ()


    //создаем слайдер времени
    private lazy var sliderTime: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    //создаем слайдер громкости
    private lazy var sliderSound: UISlider = {
        let slider = UISlider()
        slider.value = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    // создаем стек для слайдера и стека с минутами
    private lazy var stackTimerView: UIStackView = {
        let stackTimer = UIStackView()
        stackTimer.axis = .vertical
        stackTimer.spacing = 15
        stackTimer.distribution = .fillEqually
        stackTimer.translatesAutoresizingMaskIntoConstraints = false

        return stackTimer
    } ()

    // создаем стек для слайдера громкости
    private lazy var stackSoundView: UIStackView = {
        let stackSound = UIStackView()
        stackSound.axis = .horizontal
        stackSound.spacing = 10
        stackSound.distribution = .fillProportionally
        stackSound.translatesAutoresizingMaskIntoConstraints = false

        return stackSound
    } ()

    //создаем стек для лейблов с минутами
    private lazy var stackTime: UIStackView = {
        let stackTime = UIStackView()
        stackTime.axis = .horizontal
        stackTime.distribution = .fillProportionally
        stackTime.translatesAutoresizingMaskIntoConstraints = false

        return stackTime
    } ()

    // создаем лейблы с минутам
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

    // создаем лейбл с именем исполнителя
    private lazy var nameAuthorLabel: UILabel = {
        let labelArtist = UILabel()
        labelArtist.text = "Author"
        labelArtist.textColor = .systemPink
        labelArtist.font = UIFont.systemFont(ofSize: 24, weight: .light)
        labelArtist.numberOfLines = 0
        labelArtist.translatesAutoresizingMaskIntoConstraints = false

        return labelArtist
    } ()

    // создаем лейбл с названием трека
    private lazy var nameTrackLabel: UILabel = {
        let labelTrack = UILabel()
        labelTrack.text = "Track title"
        labelTrack.textColor = .black
        labelTrack.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        labelTrack.numberOfLines = 0
        labelTrack.translatesAutoresizingMaskIntoConstraints = false

        return labelTrack
    } ()

    //создаем картинку с громкостью min
    private lazy var soundMinImage: UIImageView = {
        let soundMin = UIImageView()
        soundMin.image = UIImage(named: "min")
        soundMin.translatesAutoresizingMaskIntoConstraints = false

        return soundMin
    } ()

    //создаем картинку с громкостью max
    private lazy var soundMaxImage: UIImageView = {
        let soundMax = UIImageView()
        soundMax.image = UIImage(named: "max")
        soundMax.translatesAutoresizingMaskIntoConstraints = false

        return soundMax
    } ()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()

    }

    private func setupView() {
        view.addSubview(trackImageView)
        view.addSubview(stackView)

        stackView.addArrangedSubview(stackTimerView)
        stackView.addArrangedSubview(labelStackView)
        stackTimerView.addArrangedSubview(sliderTime)
        stackTimerView.addArrangedSubview(stackTime)

        stackTime.addArrangedSubview(leftTimeLabel)
        stackTime.addArrangedSubview(rightTimeLabel)
        labelStackView.addArrangedSubview(nameTrackLabel)
        labelStackView.addArrangedSubview(nameAuthorLabel)

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

            self.trackImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.trackImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.trackImageView.heightAnchor.constraint(equalToConstant: 250),
            self.trackImageView.widthAnchor.constraint(equalToConstant: 250),


            self.stackView.topAnchor.constraint(equalTo: self.trackImageView.bottomAnchor, constant: 30),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),


            self.stackTimerView.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            self.stackTimerView.heightAnchor.constraint(equalToConstant: 44),


            self.labelStackView.topAnchor.constraint(equalTo: self.stackTime.bottomAnchor, constant: 10),
            self.nameTrackLabel.heightAnchor.constraint(equalToConstant: 20),
            self.nameAuthorLabel.heightAnchor.constraint(equalToConstant: 20),

            self.сontrollersStackView.topAnchor.constraint(equalTo: self.labelStackView.bottomAnchor, constant: 20),

            self.soundMinImage.heightAnchor.constraint(equalToConstant: 17),
            self.soundMinImage.widthAnchor.constraint(equalToConstant: 17),
            self.soundMaxImage.heightAnchor.constraint(equalToConstant: 17),
            self.soundMaxImage.widthAnchor.constraint(equalToConstant: 17)

        ])
    }
    //MARK: - Navigation

    @objc func playPauseAction() {

    }

    @objc func previousTrack() {

    }

    @objc func nextTrack() {

    }

}
//MARK: - Extension

extension UIButton {

    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }

    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2))
    }

    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }

    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 8,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)

    }

}
