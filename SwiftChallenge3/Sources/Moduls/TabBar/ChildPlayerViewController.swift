//
//  ChildPlayerViewController.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 27.09.2022.
//

import UIKit

//TODO: - Это вью удалим когда будет кнопка диссмисс в PlayerViewController.
class ChildPlayerViewController: UIViewController {
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(dismissBTTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(dismissButton)
        
        // set constraints
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.26).isActive = true
    }
    
    @objc func dismissBTTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
