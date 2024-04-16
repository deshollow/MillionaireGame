//
//  RulesView.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit

class RulesView: UIView {
    let backgroundImage = UIImageView(image: UIImage(named: "bg")!)
    let logoLabel = UILabel(text: "Правила игры")
    let rulesLabel = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let homeButton = UIButton(text: "Назад", alignment: .center)
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    func setupUI() {
        backgroundImage.contentMode = .scaleAspectFill
        
        logoLabel.font = UIFont(name: "Gilroy-Bold", size: 35)
        logoLabel.textAlignment = .center
        
        rulesLabel.text = rules
        rulesLabel.font = UIFont(name: "Gilroy-Bold", size: 17)
        rulesLabel.backgroundColor = .clear
        rulesLabel.textColor = .white
        rulesLabel.showsVerticalScrollIndicator = false
        
        let stack = UIStackView(arrangedSubviews: [logoLabel,
                                                   rulesLabel,
                                                   homeButton])
        stack.axis = .vertical
        stack.spacing = 3
        
        addSubview(backgroundImage)
        addSubview(stack)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

struct RulesViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = RulesView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
