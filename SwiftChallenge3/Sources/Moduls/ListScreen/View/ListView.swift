import UIKit
import SnapKit

class ListView : BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        enum TrackTableView {
            static let bot: CGFloat = -80
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let separator = UITableViewCell.SeparatorStyle.none
        }
    }
    
    // MARK: - UI Elements
    
    let trackTableView = UITableView()
    
    // MARK: - Initilization
    
    override func configure() {
        configureTableView()
    }
}

// MARK: - Private Methods

 private extension ListView {
    
    func configureTableView() {
        
        trackTableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)

        addSubview(trackTableView)
        trackTableView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottomMargin).offset(Constants.TrackTableView.bot)
            make.leading.equalTo(snp.leading).offset(Constants.TrackTableView.leading)
            make.trailing.equalTo(snp.trailing).offset(Constants.TrackTableView.trailing)
        }
    }
}


