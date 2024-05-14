//
//  StartView.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit

class StartView: UIView {
    let backgroundImage = UIImageView(image: UIImage(named: "bg")!)
    let logoImage = UIImageView(image: UIImage(named: "logo")!)
    let mainLabel = UILabel()
    let rulesButton = UIButton(text: "Правила игры", alignment: .center)
    let startButton = UIButton(text: "Начало игры", alignment: .center)
    
    init() {
        super.init(frame: CGRect())
        setupUI()
        
    }
    func setupUI() {
        backgroundImage.contentMode = .scaleAspectFill
        logoImage.contentMode = .scaleAspectFit
        mainLabel.text = "Кто хочет стать миллионером?"
        mainLabel.numberOfLines = 2
        mainLabel.font = UIFont(name: "Gilroy-Bold", size: 38)
        mainLabel.textColor = .white
        mainLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [logoImage, mainLabel, rulesButton,startButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        addSubview(backgroundImage)
        addSubview(stack)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImage.bottomAnchor.constraint(equalTo: mainLabel.topAnchor, constant: 30),
            logoImage.widthAnchor.constraint(equalToConstant: 225),
            logoImage.heightAnchor.constraint(equalToConstant: 225),
            
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 41),
            stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIButton {
    convenience init(title: String, bg: UIColor) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Gilroy-Regular", size: 25)
        backgroundColor = bg
        layer.cornerRadius = 12
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

import SwiftUI

struct StartViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = StartView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}

