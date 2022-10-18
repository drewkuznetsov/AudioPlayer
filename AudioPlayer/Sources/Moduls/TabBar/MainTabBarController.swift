import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Constants
    
    enum Constants {
        
        enum TapBar {
            static let positionOnX: CGFloat = 10
            static let positionOnY: CGFloat = 2
        }
        
        enum Container {
            static let cornerRadius: CGFloat = 32
            static let leading: CGFloat = 13
            static let trailing: CGFloat = -13
            static let bottom: CGFloat = -4
            static let height: CGFloat = 64
        }
    }
    
    ///Контейнер вью в котором находятся кнопки и миниплеер.
    private lazy var containerView = UIView()
    private lazy var miniPlayer = MiniPlayerViewController()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miniPlayer.delegate = self
        configure()
    }
}

// MARK: - MiniPlayerDelegate

extension MainTabBarController: MiniPlayerDelegate {
    
    ///Функция делегата которая после диссмиса детального просмотра трека возвращает Мини-Плеер назад.
    func presentPlayerVC() {
        let vc = PlayerViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func hidePlayerView() {
        UIView.animate(withDuration: 0.3) { [self] in
            containerView.isHidden = true
            miniPlayer.dismiss(animated: true)
        }
    }
}

// MARK: - Private Methods

private extension MainTabBarController {
    
    func configure() {
        setControllers()
        setupMiniPlayer()
        configureConstraints()
        configureApppearance()
    }
    
    func setControllers() {
        viewControllers = [
            generateViewController(rootViewController: MainViewController(), imageVC: "music.note.list", titleVC: "Main"),
            generateViewController(rootViewController: ListViewController(), imageVC: "list.star", titleVC: "List"),
            generateViewController(rootViewController: SearchViewController(), imageVC: "magnifyingglass.circle", titleVC: "Search")
        ]
    }
    
    func generateViewController(rootViewController: UIViewController, imageVC: String, titleVC: String) -> UIViewController {
        if let player = rootViewController as? PlayerViewController {
            player.delegate = miniPlayer
        }
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(systemName: imageVC)
        navigationVC.tabBarItem.title = titleVC
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    
    func configureApppearance() {
        view.backgroundColor = .white
        self.tabBar.tintColor = .purple
        
        containerView.layer.cornerRadius = Constants.Container.cornerRadius
        
        let width = tabBar.bounds.width - Constants.TapBar.positionOnX * Constants.TapBar.positionOnY
        let height = tabBar.bounds.height + Constants.TapBar.positionOnY
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: Constants.TapBar.positionOnX,
                                y: tabBar.bounds.minY - Constants.TapBar.positionOnY,
                                width: width, height: height),
            cornerRadius: height / Constants.TapBar.positionOnY)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: .zero)
        
        tabBar.itemWidth = width / Constants.TapBar.positionOnY
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.anotherWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    
    func setupMiniPlayer() {
        view.addSubview(containerView)
        addChild(miniPlayer)
        containerView.addSubview(miniPlayer.view)
        miniPlayer.didMove(toParent: self)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints { make in
            let safeArea = view.safeAreaLayoutGuide.snp
            
            make.leading.equalTo(safeArea.leading).offset(Constants.Container.leading)
            make.trailing.equalTo(safeArea.trailing).offset(Constants.Container.trailing)
            make.bottom.equalTo(tabBar.snp.top).offset(Constants.Container.bottom)
            make.height.equalTo(Constants.Container.height)
        }
        
        miniPlayer.view.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.top.equalTo(containerView.snp.top)
            make.bottom.equalTo(containerView.snp.bottom)
        }
    }
}
