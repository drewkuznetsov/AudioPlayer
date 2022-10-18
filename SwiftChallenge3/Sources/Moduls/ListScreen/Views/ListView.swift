import UIKit
import SnapKit

class ListView: BaseView {
    
    lazy var tableView = UITableView()
    
    override func configure() {
        setTableViewCell()
        configureConstraints()
    }
    
    func setTableViewCell() {
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)
    }
}

// MARK: - Private Methods

private extension ListView {
    
    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(safeAreaLayoutGuide.snp.height)
        }
    }
}
