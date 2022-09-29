//
//  UiButton + Extension.swift
//  SwiftChallenge3
//
//  Created by Ilya Vasilev on 28.09.2022.
//

import Foundation
import UIKit

//MARK: - Extension + UIButton
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
                       initialSpringVelocity: 4,
                       options: [.curveEaseInOut],
                       animations: {
            button.transform = transform
        }, completion: nil)
        
    }
}
