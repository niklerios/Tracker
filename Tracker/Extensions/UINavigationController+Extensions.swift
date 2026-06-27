//
//  UINavigationController+Extensions.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

extension UINavigationController {
    enum Style { case standard }
    
    convenience init(root: UIViewController) {
        self.init(rootViewController: root)
    }

    @discardableResult
    func withStyle(_ style: Style) -> Self {
        switch style {
        case .standard:
            setStandardStyle()
        }
        
        return self
    }
    
    private func setStandardStyle() {
        let mainColor: UIColor = .colorBlack

        // Сделать заголовки большими
        navigationBar.prefersLargeTitles = true

        // Установить параметры текста для больших заголовков
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: mainColor
        ]

        // Установить цвет кнопок в navigationBar
        navigationBar.tintColor = mainColor
    }
}
