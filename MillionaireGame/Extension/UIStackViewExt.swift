//
//  UIStackViewExt.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit
//расширение для стека
extension UIStackView {
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: Alignment = .center) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
}
