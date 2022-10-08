import UIKit
import SnapKit

class MainView : BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        enum SongTableView {
            static let bot: CGFloat = -50
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let separator = UITableViewCell.SeparatorStyle.none
        }
    }
    
    // MARK: - UI Elements
    
    let songTableView = UITableView()
    
    var favourites: PlayListModel? {
        didSet {
            songTableView.reloadData()
            print("FAVOURITES UPDATED")
        }
    }
    
    var recentlyPlayed: PlayListModel? {
        didSet {
            songTableView.reloadData()
            print("RECENT UPDATED")
        }
    }
    // MARK: - Initilization
    override func configure() {
        configureConstraints()
        configureSongTableView()
    }
}

// MARK: - Private Methods

private extension MainView {
    
    func configureSongTableView() {
        songTableView.register(MainSongCell.self, forCellReuseIdentifier: MainSongCell.reuseIdentifier)
        songTableView.allowsSelection = false
        songTableView.separatorStyle = Constants.SongTableView.separator
        songTableView.sectionHeaderTopPadding = 0
    }
    
    func configureConstraints() {
        addSubview(songTableView)
        songTableView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom).offset(Constants.SongTableView.bot)
            make.leading.equalTo(snp.leading).offset(Constants.SongTableView.leading)
            make.trailing.equalTo(snp.trailing).offset(Constants.SongTableView.trailing)
        }
    }
}

