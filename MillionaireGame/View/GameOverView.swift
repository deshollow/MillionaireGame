//
//  GameOverView.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit

class GameOverView: UIView {
    
    //действие по тапу на кнопку рестарта игры
    var onTap: (() -> Void)?
    
    private let questionIndex: Int
    //несгораемая сумма для экрана 'Game Over', если она была достигнута
    private var milestone: String?
    private let wonMillion: Bool
    private let tookMoney: Bool
    
    private let background = UIImageView(image: UIImage(named: "bg")!)
    private let logo = UIImageView()
    private let gameOverLabel = UILabel(text: "ИГРА ОКОНЧЕНА")
    private let milestoneLabel = UILabel()
    private let emojiLabel = UILabel()
    private let loseLabel = UILabel()
    
    private let restartButton = UIButton(text: "Играть заново", alignment: .center)
    
    init(questionIndex: Int, tookMoney: Bool) {
        self.questionIndex = questionIndex
        self.milestone = Quiz.lastMilestone
        self.wonMillion = {Quiz.lastMilestone == Quiz.milestoneSums.last}()
        self.tookMoney = tookMoney
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        
        background.contentMode = .scaleAspectFill
        
        logo.image = UIImage(imageLiteralResourceName: "logo")
        logo.contentMode = .scaleAspectFit
        
        gameOverLabel.font = UIFont(name: "Gilroy-Bold", size: 38)
        emojiLabel.font = .systemFont(ofSize: 250)
        
        milestoneLabel.font = UIFont(name: "Gilroy-Bold", size: 23)
        loseLabel.font = UIFont(name: "Gilroy-Bold", size: 23)
        loseLabel.textColor = .white
        
        if tookMoney {
            loseLabel.text = "Взял деньги на \(questionIndex + 1) вопросе"
        } else {
            loseLabel.text = "Проигрыш на \(questionIndex + 1) вопросе"
        }
        
        restartButton.setBackgroundImage(UIImage(named: "Rectangle 3"), for: .normal)
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        
        //проверяем, была ли достигнута несгораемая сумма, и в зависимости от этого показываем/не показываем текст с выигрышем и соответсвующим эмодзи
        if let milestone = milestone {
            milestoneLabel.isHidden = false
            milestoneLabel.textColor = .white
            emojiLabel.text = "💰"
            if tookMoney {
                milestoneLabel.text = "Вы забрали \(milestone)!"
            } else {
                milestoneLabel.text = "Вы выиграли \(milestone)!"
            }
        } else {
            milestoneLabel.isHidden = true
            emojiLabel.text = "😓"
        }
        
        //UI если выиграл миллион
        if wonMillion {
            gameOverLabel.text = "Поздравляем!"
            milestoneLabel.text = "Вы выиграли миллион!"
            loseLabel.text = "Все вопросы отвечены верно"
            
        }
        
        let mainStack = UIStackView(views: [logo,
                                            gameOverLabel,
                                            milestoneLabel,
                                            emojiLabel,
                                            loseLabel,
                                            restartButton,
                                           ],
                                    axis: .vertical,
                                    spacing: 15)
        
        addSubview(background)
        addSubview(mainStack)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //действие по тапу на кнопку рестарта игры
    @objc private func restartTapped(_ sender: UIButton) {
        onTap?()
    }
}
import SwiftUI
struct GameOverViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = GameOverView(questionIndex: 0, tookMoney: false)
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
