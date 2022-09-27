//
//  MainTabBarController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit
import SwiftUI
class MainTabBarController: UITabBarController, MiniPlayerDelegate {
    //MARK: - Let / var
    let miniPlayer = MiniPlayerViewController()
    
    private lazy var containerView : UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
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
            generateViewController(rootViewController: MainViewController(), imageVC: "music.note.list", titelVC: "Main"),
            generateViewController(rootViewController: ListViewController(), imageVC: "list.star", titelVC: "List"),
            generateViewController(rootViewController: PlayerViewController(), imageVC: "play.circle", titelVC: "Player"),
            generateViewController(rootViewController: SearchViewController(), imageVC: "magnifyingglass.circle", titelVC: "Search")
        ]
        
        setConstraints()
        miniPlayer.delegate = self
    }
    
    //MARK: - Methods
    ///Функция делегата которая после диссмиса детального просмотра трека возвращает Мини-Плеер назад.
    func presentPlayerView() {
        let vc = ChildPlayerViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    ///Функция установки мини-плеера.
    func setupMiniPlayer() {
        view.addSubview(containerView)
        addChild(miniPlayer)
        containerView.addSubview(miniPlayer.view)
        miniPlayer.didMove(toParent: self)
    }
    
    private func generateViewController(rootViewController: UIViewController, imageVC: String, titelVC: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(systemName: imageVC)
        navigationVC.tabBarItem.title = titelVC
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    
    ///Устанавливаем констрейны для контейнер-вью и мини-плеера внутри него.
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            let safeArea = view.safeAreaLayoutGuide.snp
            
            make.leading.equalTo(safeArea.leading)
            make.trailing.equalTo(safeArea.trailing)
            make.bottom.equalTo(tabBar.snp.top).offset(-16)
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
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .automatic
        
        ///Цвета тап-бара.
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
