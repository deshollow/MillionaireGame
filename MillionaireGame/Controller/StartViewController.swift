//
//  ViewController.swift
//  MillionaireGame
//
//  Created by deshollow on 15.04.2024.
//

import UIKit

class StartViewController: UIViewController {
    let mainView = StartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        addActions()
        
    }
    ///экшн на кнопки
    func addActions() {
        let tapRules = UIAction { _ in
            print("переход в правила")
            let vc = RulesViewController()
            self.present(vc, animated: true)
        }
        let tapStart = UIAction { _ in
            print("переход на экран вопросов")
            let vc = GameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.rulesButton.addAction(tapRules, for: .touchUpInside)
        mainView.startButton.addAction(tapStart, for: .touchUpInside)
    }
}


