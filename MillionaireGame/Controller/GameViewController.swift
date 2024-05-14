//
//  GameViewController.swift
//  MillionaireGame
//
//  Created by deshollow on 17.04.2024.
//

import UIKit

class GameViewController: UIViewController {
    let mainView = GameView()
    var quiz = Quiz()
    var timer = Timer()
    var secondTotal = 30
    var secondPassed = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        updateQuestionAndSum()
        SoundManager.shared.playSound(soundFileName: "zvukChasov")
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        quiz.restartGame()
        
        answerButtonsTapped()
        exitButton()
        showProgressButtonTapped()
        takeMoneyButtonTapped()
        
        help5050Button()
        helpPhoneButton()
        helpHumansButton()
        helpMistakeButton()
        
    }
    // MARK: - обновление UI и обработчики нажатия
    //обновление вопросов и сумм
    func updateQuestionAndSum() {
        mainView.questionTextLabel.text = quiz.getQuestion()
        mainView.buttonAnswerA.setTitle(quiz.getAnswers()[0], for: .normal)
        mainView.buttonAnswerB.setTitle(quiz.getAnswers()[1], for: .normal)
        mainView.buttonAnswerC.setTitle(quiz.getAnswers()[2], for: .normal)
        mainView.buttonAnswerD.setTitle(quiz.getAnswers()[3], for: .normal)
        normalColor()
        mainView.questionNumberLabel.text = "Вопрос \(quiz.currentQuestionNumber)/\(Quiz.sums.count)"
        if let currentSum = Quiz.sums[quiz.currentQuestionNumber] {
            mainView.sumTotalLabel.text = currentSum
        }
    }
    //возвращает цвет кнопок
    func normalColor() {
        self.mainView.buttonAnswerA.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerB.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerC.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerD.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
    }
    //нажатие на варианты ответов
    func answerButtonsTapped() {
        let tap = UIAction { action in
            
            guard let button = action.sender as? UIButton else { return }
            //смена цвета при выборе ответа
            self.animateWait(button: button)
            self.updateTimer()
            
            let answerIndex: Int
            switch button {
            case self.mainView.buttonAnswerA:
                answerIndex = 0
            case self.mainView.buttonAnswerB:
                answerIndex = 1
            case self.mainView.buttonAnswerC:
                answerIndex = 2
            case self.mainView.buttonAnswerD:
                answerIndex = 3
            default:
                return
            }
            
            let isCorrectAnswer = self.quiz.checkAnswer(answerIndex)
            if isCorrectAnswer {
                
                print("Верный ответ!")
                //подстветка зеленым при правильно ответе
                self.animateAnswer(button: button, iscorrect: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.updateQuestionAndSum()
                    
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: true)
                    self.navigationController?.pushViewController(vc, animated: true)
                    button.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                
            } else {
                
                print("Неверный ответ!")
                self.animateAnswer(button: button, iscorrect: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: false)
                    self.navigationController?.pushViewController(vc, animated: true)
                    button.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
            }
            self.stopTimer(stopSound: false)
        }
        mainView.buttonAnswerA.addAction(tap, for: .touchUpInside)
        mainView.buttonAnswerB.addAction(tap, for: .touchUpInside)
        mainView.buttonAnswerC.addAction(tap, for: .touchUpInside)
        mainView.buttonAnswerD.addAction(tap, for: .touchUpInside)
    }
    // MARK: - верхние кнопки
    //показать прогресс игры в таблице
    func showProgressButtonTapped() {
        let tap = UIAction { _ in
            print("show progress")
            let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber)
            vc.dismissProgress = {self.dismiss(animated: true)}
            self.present(vc, animated: true)
        }
        mainView.showProgressButton.addAction(tap, for: .touchUpInside)
    }
    //алерт по кнопке выйти
    func exitButton() {
        let tap = UIAction { _ in
            let customAlert = CustomAlertViewController()
            customAlert.exitAction = {
                let vc = StartViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.stopTimer(stopSound: true)
                print("выход")
            }
            self.present(customAlert, animated: true, completion: nil)
        }
        mainView.exitButton.addAction(tap, for: .touchUpInside)
    }
    //нижняя забрать деньги
    func takeMoneyButtonTapped() {
        let tap = UIAction { _ in
            print("забрать деньги")
            self.straightToGameOver(tookMoney: true)
            self.stopTimer(stopSound: true)
        }
        mainView.takeMoneyButton.addAction(tap, for: .touchUpInside)
    }
    // MARK: - 4 кнопки помощи)
    //5050
    func help5050Button() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA,
                                  self.mainView.buttonAnswerB,
                                  self.mainView.buttonAnswerC,
                                  self.mainView.buttonAnswerD]
            
            let indexOfRight = self.quiz.getRightAnswerIndex()
            arrayOfButtons.remove(at: indexOfRight)
            arrayOfButtons[0].setTitle(nil, for: .normal)
            arrayOfButtons[1].setTitle(nil, for: .normal)
            
            button.setImage(UIImage(named: "5050_off"), for: .normal)
            button.isEnabled = false
        }
        mainView.help5050Button.addAction(tap, for: .touchUpInside)
    }
    //звонок другу
    func helpPhoneButton() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA,
                                  self.mainView.buttonAnswerB,
                                  self.mainView.buttonAnswerC,
                                  self.mainView.buttonAnswerD]
            
            let indexOfRight = self.quiz.getRightAnswerIndex()
            let probability = Int.random(in: 1...100)
            
            switch probability {
            case 1...70:
                arrayOfButtons[indexOfRight].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            default:
                arrayOfButtons.remove(at: indexOfRight)
                arrayOfButtons[Int.random(in: 0...2)].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            }
            button.setImage(UIImage(named: "call_off"), for: .normal)
            button.isEnabled = false
        }
        mainView.helpPhoneButton.addAction(tap, for: .touchUpInside)
    }
    //помощь зала
    func helpHumansButton() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA, self.mainView.buttonAnswerB, self.mainView.buttonAnswerC, self.mainView.buttonAnswerD]
            let indexOfRight = self.quiz.getRightAnswerIndex()
            let probability = Int.random(in: 1...100)
            switch probability {
            case 1...80:
                arrayOfButtons[indexOfRight].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            default:
                arrayOfButtons.remove(at: indexOfRight)
                arrayOfButtons[Int.random(in: 0...2)].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            }
            button.setImage(UIImage(named: "people_off"), for: .normal)
            button.isEnabled = false
        }
        mainView.helpHumansButton.addAction(tap, for: .touchUpInside)
    }
    //право на ошибку
    //обработчик нажатия кнопки
    func helpMistakeButton() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }



            self.mainView.buttonAnswerA.removeTarget(nil, action: nil, for: .allEvents)
            self.mainView.buttonAnswerB.removeTarget(nil, action: nil, for: .allEvents)
            self.mainView.buttonAnswerC.removeTarget(nil, action: nil, for: .allEvents)
            self.mainView.buttonAnswerD.removeTarget(nil, action: nil, for: .allEvents)

            button.setImage(UIImage(named: "mistakenew_off"), for: .normal)
            button.isEnabled = false
            self.heplMistakeButtonLogic()
        }
        mainView.helpMistakeButton.addAction(tap, for: .touchUpInside)
    }
    //логика работы кнопки
    func heplMistakeButtonLogic() {

        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            let arrayOfButtons = [self.mainView.buttonAnswerA, self.mainView.buttonAnswerB, self.mainView.buttonAnswerC, self.mainView.buttonAnswerD]

            let answerIndex: Int
            switch button {
            case self.mainView.buttonAnswerA:
                answerIndex = 0
            case self.mainView.buttonAnswerB:
                answerIndex = 1
            case self.mainView.buttonAnswerC:
                answerIndex = 2
            case self.mainView.buttonAnswerD:
                answerIndex = 3
            default:
                return
            }
            print("ret")

            let indexOfRight = self.quiz.getRightAnswerIndex()

                if answerIndex == indexOfRight {
                    self.answerHelpMistakeButton(index: answerIndex)
                    print("right")
                    self.secondPassed = 0
                    self.timer.invalidate()
                }
                else {
                    print("fkjllkf")
                    arrayOfButtons[answerIndex].setBackgroundImage(UIImage(named: "Rectangle 5"), for: .normal)
                    self.mainView.buttonAnswerA.removeTarget(nil, action: nil, for: .allEvents)
                    self.mainView.buttonAnswerB.removeTarget(nil, action: nil, for: .allEvents)
                    self.mainView.buttonAnswerC.removeTarget(nil, action: nil, for: .allEvents)
                    self.mainView.buttonAnswerD.removeTarget(nil, action: nil, for: .allEvents)
                    self.answerButtonsTapped()
                }

        }

        self.mainView.buttonAnswerA.addAction(tap, for: .touchUpInside)
        self.mainView.buttonAnswerB.addAction(tap, for: .touchUpInside)
        self.mainView.buttonAnswerC.addAction(tap, for: .touchUpInside)
        self.mainView.buttonAnswerD.addAction(tap, for: .touchUpInside)

    }
    //функция для проверки ответа при нажатой кнопке право на ошибку
     func answerHelpMistakeButton(index: Int) {
         print("ans")

         let arrayOfButtons = [self.mainView.buttonAnswerA, self.mainView.buttonAnswerB, self.mainView.buttonAnswerC, self.mainView.buttonAnswerD]
         arrayOfButtons[index].setBackgroundImage(UIImage(named: "Rectangle 4"), for: .normal)
         let isCorrectAnswer = self.quiz.checkAnswer(index)
         if isCorrectAnswer {
            
             print("Верный ответ!")
             // подстветка зеленым при правильно ответе
             DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                 SoundManager.shared.playSound(soundFileName: "otvetVernyiy")
                 arrayOfButtons[index].setBackgroundImage(UIImage(named: "Rectangle 3"), for: .normal)
             }
            
             DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                 self.updateQuestionAndSum()
                 
                 let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: true)
                 self.navigationController?.pushViewController(vc, animated: true)
                 arrayOfButtons[index].setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
             }
             SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                  
         }
         self.stopTimer(stopSound: false)
     }
    // MARK: - транзишн и таймер
    //переход  в gameOver
    func straightToGameOver(tookMoney: Bool = false) {
        if tookMoney {
            let vc = GameOverViewController(questionIndex: self.quiz.currentQuestionNumber - 1, tookMoney: true)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = GameOverViewController(questionIndex: self.quiz.currentQuestionNumber - 1)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    //старт таймера
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    //обновляем таймер
    @objc func updateTimer() {
        if secondPassed < secondTotal {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(secondTotal)
            mainView.timerProgress.setProgress(percentageProgress, animated: true)
        } else {
            SoundManager.shared.stopSound()
            SoundManager.shared.playSound(soundFileName: "budilnik")
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.straightToGameOver()
                self?.secondPassed = 0
            }
        }
    }
    //стоп  таймер
    func stopTimer(stopSound: Bool) {
        timer.invalidate()
        secondPassed = 0
        if stopSound == true {
            SoundManager.shared.stopSound()
        }
    }
    // MARK: - анимация
    //анимация кнопки
    func animateAnswer(button: UIButton, iscorrect: Bool) {
        let buttonColor: UIImage
        let soundName: String
        if iscorrect {
            buttonColor = UIImage.rectangle3
            soundName = "otvetVernyiy"
        } else {
            buttonColor = UIImage.rectangle5
            soundName = "zvukNepravilnogo"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            SoundManager.shared.playSound(soundFileName: soundName)
            UIView.transition(with: button,
                              duration: 0.5,
                              options: [.repeat],
                              animations: { button.setBackgroundImage(buttonColor, for: .normal) },
                              completion: {(bool) in
                UIView.transition(with: button,
                                  duration: 0.5,
                                  options: [.transitionCrossDissolve, .repeat],
                                  animations: { button.setBackgroundImage(UIImage(named: "Rectangle 4"), for: .normal) },
                                  completion: nil)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1 , execute: {
                button.layer.removeAllAnimations()
                button.setBackgroundImage(buttonColor, for: .normal)
            })
        }
    }
    //ожидание
    func animateWait(button: UIButton) {
        UIView.transition(with: button,
                          duration: 1.5,
                          options: [.allowAnimatedContent, .transitionCrossDissolve],
                          animations: { button.setBackgroundImage(.rectangle4, for: .normal) },
                          completion: nil)
    }
}
