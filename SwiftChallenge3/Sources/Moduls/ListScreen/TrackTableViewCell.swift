//
//  TrackTableViewCell.swift
//  SwiftChallenge3
//
//  Created by Даниил Симахин on 22.09.2022.
//

import UIKit
import SnapKit

class TrackTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: TrackTableViewCell.self)
    var track: TrackModel! {
        didSet {
            trackImageView.image = UIImage(named: "test")
            if let coverURL = track.coverURL {
                trackImageView.downloadedFrom(link: coverURL)
            }
            trackNameLabel.text = track.trackName
            artistNameLabel.text = track.artistName
        }
    }
    
    private let trackImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let trackNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    private let artistNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 14, weight: .light)
        return view
    }()
    private lazy var favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        trackImageView.layer.cornerRadius = 70 / 2
        trackImageView.layer.masksToBounds = true
        
        trackImageView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.height.equalTo(70)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(25)
            make.left.equalTo(trackImageView.snp.right).offset(15)
            make.right.equalTo(favoriteButton.snp.left).offset(-10)
            make.bottom.equalTo(contentView).offset(-25)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.width.equalTo(50)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    private func configureUI() {
        contentView.addSubview(trackImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(favoriteButton)
        stackView.addArrangedSubview(trackNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
    }
    
    @objc private func favoriteButtonPressed(sender: UIButton!) {
        if favoriteButton.image(for: .normal) == UIImage(systemName: "heart") {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
