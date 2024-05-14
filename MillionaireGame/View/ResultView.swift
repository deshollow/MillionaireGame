//
//  ResultView.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit

class ResultView: UIView, UITableViewDataSource {
    
    //переход на другой экран по закрытию экрана с результатами в зависимости от правильности ответа
    var nextVC: (() -> Void)?
    //закрытие экрана пргресса
    var closeProgress: (() -> Void)?
    private let questionIndex: Int
    private let isCorrectAnswer: Bool?
    private let exitButton = UIButton(type: .system)
    
    private let background = UIImageView()
    private let logo = UIImageView()
    private let tableView = UITableView(frame: CGRect(), style: .plain)
    
    init(questionIndex: Int, isCorrectAnswer: Bool?) {
        self.questionIndex = questionIndex
        self.isCorrectAnswer = isCorrectAnswer
        super.init(frame: .zero)
        //сохраняем несгораемую сумму, если она была достигнута
        if let isCorrectAnswer {
            let sortedSums = Quiz.sums.sorted { $0.key < $1.key }
            if Quiz.milestoneSums.contains(sortedSums.map { $0.value }[questionIndex]) && isCorrectAnswer {
                Quiz.lastMilestone = sortedSums[questionIndex].value
            }
            //переход на следующий экран через 3 секунды (время проигрывания звука верного/неверного ответа)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                //передаем в замыкание выхода с экрана результатов последнюю достигнутую несгораемую сумму, если она была достигнута. Для ее дальнейшей передачи и отображения на экране 'Game Over'
                self?.nextVC?()
            }
        }
        
        setupUI()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.rowHeight = tableView.bounds.height / CGFloat(tableView.numberOfRows(inSection: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        background.image = UIImage(imageLiteralResourceName: "bg")
        background.contentMode = .scaleAspectFill
        
        logo.image = UIImage(imageLiteralResourceName: "logo")
        logo.contentMode = .scaleAspectFit
        
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        exitButton.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
        exitButton.tintColor = .white
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        
        addSubview(background)
        addSubview(logo)
        addSubview(tableView)
        addSubview(exitButton)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 80),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            tableView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 34),
            tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -34),
            tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -34),
            exitButton.topAnchor.constraint(equalTo: logo.topAnchor, constant: 20),
            exitButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
        
        if isCorrectAnswer != nil {
            exitButton.isHidden = true
        } else {
            exitButton.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Quiz.sums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        let sortedSums = Quiz.sums.sorted { $0.key < $1.key }
        let isMilestone: Bool = {
            Quiz.milestoneSums.contains(sortedSums.map { $0.value }.reversed()[indexPath.row])
        }()
        var didPass = false
        if Quiz.sums.count - (indexPath.row + 1) <= questionIndex {
            didPass = true
        }
        cell.setupUI(cellTotal: Quiz.sums.count, questionIndex: questionIndex, rowNumber: indexPath.row, isCorrect: isCorrectAnswer, isMilestoneSum: isMilestone, sum: sortedSums.map { $0.value }.reversed()[indexPath.row], didPass: didPass)
        
        return cell
    }
    
    @objc private func exitTapped(_ sender: UIButton) {
        closeProgress?()
    }
}
