//
//  UIButtonExt.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit

///расширение для кнопок ответов
extension UIButton {
    convenience init(text: String, alignment: UIControl.ContentHorizontalAlignment) {
        self.init()
        self.setTitle(text, for: .normal)
        self.contentHorizontalAlignment = alignment
        self.tintColor = .white
        self.titleLabel?.font = UIFont(name: "Gilroy-Regular", size: 25)
        self.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.widthAnchor.constraint(equalToConstant: 320).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        let inset: CGFloat = 15
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
    }
}
///расширение для кнопок подсказок
extension UIButton {
    convenience init(imageNamed: String, width: CGFloat, height: CGFloat) {
        self.init(type: .system)
        self.setImage(UIImage(named: imageNamed), for: .normal)
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
///расширение на алерт
extension UIButton {
    convenience init(title: String, backgroundImage: UIImage?) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont(name: "Gilroy-Regular", size: 25)
        setBackgroundImage(backgroundImage, for: .normal)
    }
}

