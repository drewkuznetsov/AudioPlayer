//
//  MainTabBarController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit
class MainTabBarController: UITabBarController, MiniPlayerDelegate {
    //MARK: - Let / var
    let miniPlayer = MiniPlayerViewController()
    
    ///Устанавливаем контейнер вью в котором находятся кнопки и имя трека.
    private lazy var containerView : UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 32
        return uiView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.tabBar.tintColor = .purple
        
        setTapBarApppearance()
        setupMiniPlayer()
        
        ///Задаём 4 кнопки вью-контроллера в тап-бар.
        viewControllers = [
            generateViewController(rootViewController: MainViewControllers(), imageVC: "music.note.list", titleVC: "Main"),
            generateViewController(rootViewController: ListViewController(), imageVC: "list.star", titleVC: "List"),
            generateViewController(rootViewController: SearchViewController(), imageVC: "magnifyingglass.circle", titleVC: "Search")
        ]
        setConstraints()
        miniPlayer.delegate = self
    }
    
    //MARK: - Methods
    
    ///Функция установки мини-плеера.
    func setupMiniPlayer() {
        view.addSubview(containerView)
        addChild(miniPlayer)
        containerView.addSubview(miniPlayer.view)
        miniPlayer.didMove(toParent: self)
    }
    
    private func generateViewController(rootViewController: UIViewController, imageVC: String, titleVC: String) -> UIViewController {
        if let player = rootViewController as? PlayerViewController {
            player.delegate = miniPlayer
        }
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(systemName: imageVC)
        navigationVC.tabBarItem.title = titleVC
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    
    ///Устанавливаем констрейны для контейнер-вью и мини-плеера внутри него.
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            let safeArea = view.safeAreaLayoutGuide.snp
            
            make.leading.equalTo(safeArea.leading).offset(13)
            make.trailing.equalTo(safeArea.trailing).offset(-13)
            make.bottom.equalTo(tabBar.snp.top).offset(-4)
            make.height.equalTo(64)
        }
        miniPlayer.view.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.top.equalTo(containerView.snp.top)
            make.bottom.equalTo(containerView.snp.bottom)
        }
    }
    ///Создаёт закруглённый тап-бар
    private func setTapBarApppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 2
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 2
        tabBar.itemPositioning = .centered
        
        ///Цвета тап-бара.
        roundLayer.fillColor = UIColor.anotherWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
//MARK: - Extension PlayerView Delegate
extension MainTabBarController {
    ///Функция делегата которая после диссмиса детального просмотра трека возвращает Мини-Плеер назад.
    func presentPlayerVC() {
        let vc = PlayerViewController()
        vc.showDismissButton()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    ///Скрытие Мини-плэера.
    func hidePlayerView() {
        UIView.animate(withDuration: 0.3) { [self] in
            containerView.isHidden = true
            miniPlayer.dismiss(animated: true)
        }
    }
}
