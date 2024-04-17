//
//  Quiz.swift
//  MillionaireGame
//
//  Created by deshollow on 15.04.2024.
//

import Foundation

struct Quiz {
    //текущий порядковый номер вопроса(не индекс)
    var currentQuestionNumber = 1
    //все суммы возможного выигрыша
    static let sums = [1: "100 RUB", 2: "200 RUB", 3: "300 RUB", 4: "500 RUB", 5: "1000 RUB", 6: "2000 RUB", 7: "4000 RUB", 8: "8000 RUB", 9: "16000 RUB", 10: "32000 RUB", 11: "64000 RUB", 12: "125000 RUB", 13: "250000 RUB", 14: "500000 RUB", 15: "1 миллион"]
    //несгораемые суммы возможного выигрыша
    static let milestoneSums = ["1000 RUB", "32000 RUB", "1 миллион"]
    //хранит последнюю несгораемую сумму, если она была достигнута
    static var lastMilestone: String?
    
    private let questions: [[Question]]
    private var currentQuestionSection = 0 //внутренняя переменная для индекса вопроса в текущей секции
    private var currentQuestionIndexInSection = 0 //внутренняя переменная для индекса текущей секции
    private let easyQuestions = [Question(questionText: "Как называется столица Франции?",
                                          answers: [Answer(text: "Мадрид"), Answer(text: "Париж"), Answer(text: "Лондон"), Answer(text: "Берлин")], correctAnswerIndex: 1),
                                 Question(questionText: "Сколько планет в Солнечной системе?",
                                          answers: [Answer(text: "7"), Answer(text: "8"), Answer(text: "9"), Answer(text: "10")], correctAnswerIndex: 1),
                                 Question(questionText: "Кто написал произведение 'Преступление и наказание'?",
                                          answers: [Answer(text: "Лев Толстой"), Answer(text: "Иван Тургенев"), Answer(text: "Федор Достоевский"), Answer(text: "Александр Пушкин")], correctAnswerIndex: 2),
                                 Question(questionText: "Как называется самая высокая гора в мире?",
                                          answers: [Answer(text: "Эверест"), Answer(text: "Аконкагуа"), Answer(text: "Килиманджаро"), Answer(text: "Макинли")], correctAnswerIndex: 0),
                                 Question(questionText: "Что из перечисленного является столицей России?",
                                          answers: [Answer(text: "Киев"), Answer(text: "Минск"), Answer(text: "Москва"), Answer(text: "Казань")], correctAnswerIndex: 2)]
    private let mediumQuestion = [Question(questionText: "Какое животное является символом США?",
                                           answers: [Answer(text: "Орел"), Answer(text: "Медведь"), Answer(text: "Буйвол"), Answer(text: "Волк")], correctAnswerIndex: 0),
                                  Question(questionText: "Какой газ является самым распространенным в атмосфере Земли?",
                                                           answers: [Answer(text: "Азот"), Answer(text: "Кислород"), Answer(text: "Углекислый газ"), Answer(text: "Аргон")], correctAnswerIndex: 0),
                                  Question(questionText: "Что из перечисленного является сухопутным хищным млекопитающим?",
                                                           answers: [Answer(text: "Дельфин"), Answer(text: "Крокодил"), Answer(text: "Тигр"), Answer(text: "Акула")], correctAnswerIndex: 2),
                                  Question(questionText: "Какая из перечисленных планет Солнечной системы самая большая?",
                                                           answers: [Answer(text: "Марс"), Answer(text: "Венера"), Answer(text: "Юпитер"), Answer(text: "Сатурн")], correctAnswerIndex: 2),
                                  Question(questionText: "Как называется процесс воспроизводства клетки?",
                                                            answers: [Answer(text: "Митоз"), Answer(text: "Мейоз"), Answer(text: "Биосинтез"), Answer(text: "Деградация")], correctAnswerIndex: 0)]
    private let hardQuestions = [Question(questionText: "Какой цвет приобретает фенолфталеин в щелочной среде?",
                                                       answers: [Answer(text: "Синий"), Answer(text: "Малиновый"), Answer(text: "Cтановится бесцветным"), Answer(text: "Остается зеленым")], correctAnswerIndex: 1),
                                 Question(questionText: "Какое из этих сражений произошло в 1790 году?",
                                                       answers: [Answer(text: "Ледовое побоище"), Answer(text: "Чесменский бой"), Answer(text: "Полтавская битва"), Answer(text: "Взятие Измаила")], correctAnswerIndex: 3),
                                 Question(questionText: "451 градус по Фаренгейту — это сколько в Цельсиях?",
                                                       answers: [Answer(text: "232,78"), Answer(text: "100"), Answer(text: "327,93"), Answer(text: "143,86")], correctAnswerIndex: 0),
                                 Question(questionText: "Кто из этих литературных героев существовал на самом деле?",
                                                       answers: [Answer(text: "Василий Теркин"), Answer(text: "Козьма Прутков"), Answer(text: "Вещий Олег"), Answer(text: "Остап Бендер")], correctAnswerIndex: 2),
                                 Question(questionText: "Какое государство самое маленькое в мире?",
                                                       answers: [Answer(text: "Мальта"), Answer(text: "Ватикан"), Answer(text: "Тувалу"), Answer(text: "Монако")], correctAnswerIndex: 1)]
    
    init() {
        //перемешиваем вопросы в каждой секции перед началом игры
        questions = [easyQuestions.shuffled(),
                     mediumQuestion.shuffled(),
                     hardQuestions.shuffled()]
    }
    
    func getQuestion() -> String {
        questions[currentQuestionSection][currentQuestionIndexInSection].questionText
    }
    
    func getAnswers() -> [String] {
        questions[currentQuestionSection][currentQuestionIndexInSection].answers.map { $0.text }
    }
    
    mutating func checkAnswer(_ answer: Int) -> Bool {
        let result = answer == questions[currentQuestionSection][currentQuestionIndexInSection].correctAnswerIndex
        nextQuestion()
        return result
    }
    
    func getRightAnswerIndex() -> Int  {
        let index = questions[currentQuestionSection][currentQuestionIndexInSection].correctAnswerIndex
        return index
    }
    
    //переход к следующему вопросу
    private mutating func nextQuestion() {
        currentQuestionNumber += 1
        if currentQuestionIndexInSection == questions[currentQuestionSection].count - 1 {
            if currentQuestionSection == questions.count - 1 {
            } else {
                currentQuestionSection += 1
                currentQuestionIndexInSection = 0
            }
        } else {
            currentQuestionIndexInSection += 1
        }
    }
    
    //рестарт игры
    mutating func restartGame() {
        currentQuestionNumber = 1
        currentQuestionSection = 0
        currentQuestionIndexInSection = 0
        Quiz.lastMilestone = nil
    }
}
