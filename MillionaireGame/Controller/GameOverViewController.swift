//
//  GameOverViewController.swift
//  MillionaireGame
//
//  Created by deshollow on 17.04.2024.
//

import UIKit

class GameOverViewController: UIViewController {
    
    private let gameVC = GameViewController()
    private let gameOverView: GameOverView
    
    init(questionIndex: Int, tookMoney: Bool = false) {
        gameOverView = GameOverView(questionIndex: questionIndex, tookMoney: tookMoney)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameVC.stopTimer(stopSound: true)
        navigationController?.navigationBar.isHidden = true
        //назначаем действие для вью по нажатию кнопки рестарт
        gameOverView.onTap = restart
        view = gameOverView
    }
    
    private func restart() {
        print("возврат на начальный экран, рестарт игры")
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SoundManager.shared.stopSound()
        SoundManager.shared.playSound(soundFileName: "boleeKachestvennyiy")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SoundManager.shared.stopSound()
    }
}
