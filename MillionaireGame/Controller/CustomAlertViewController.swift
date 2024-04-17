//
//  CustomAlertViewController.swift
//  MillionaireGame
//
//  Created by deshollow on 17.04.2024.
//

import UIKit
///кастомный алерт
class CustomAlertViewController: UIViewController {
    
    var exitAction: (() -> Void)?
    
    let alertView = UIView()
    let exitLabel = UILabel(text: "Вы точно хотите выйти?")
    let yesButton = UIButton(title: "Да", backgroundImage: UIImage(named: "Rectangle 3"))
    let noButton = UIButton(title: "Нет", backgroundImage: UIImage(named: "Rectangle 5"))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        alertTap()
    }
    func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        alertView.backgroundColor = UIColor(named: "gameBlue")
        alertView.layer.cornerRadius = 10
        
        let stack = UIStackView(arrangedSubviews: [exitLabel,
                                                   yesButton,
                                                   noButton,])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(alertView)
        alertView.addSubview(stack)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 330),
            
            stack.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
        ])
    }
    //обработчики кнопок
    func alertTap() {
        let tapYes = UIAction { _ in
            self.exitAction?()
            self.dismiss(animated: true, completion: nil)
            SoundManager.shared.stopSound()
            print("выход")
        }
        let tapNo = UIAction { _ in
            self.dismiss(animated: true)
            print("отмена выхода")
        }
        yesButton.addAction(tapYes, for: .touchUpInside)
        noButton.addAction(tapNo, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
