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
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-25)
        }
    }
    
    private func configureUI() {
        contentView.addSubview(trackImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(trackNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
    }
    
    func configure(_ track: TrackModel) {
//        trackImageView.image = UIImage(named: track.previewURL)
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
    }
}
