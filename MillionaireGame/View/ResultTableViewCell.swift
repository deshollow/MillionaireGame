//
//  ResultTableViewCell.swift
//  MillionaireGame
//
//  Created by deshollow on 16.04.2024.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    private let background = UIImageView()
    private let questionLabel = UILabel()
    private let sumLabel = UILabel()
    private var didPass = false
    
    func setupUI(cellTotal: Int, questionIndex: Int, rowNumber: Int, isCorrect: Bool?, isMilestoneSum: Bool, sum: String, didPass: Bool) {
        
        isUserInteractionEnabled = false
        self.didPass = didPass
        
        background.contentMode = .scaleAspectFill
        background.image = calculateBackground(rowNumber: rowNumber, isMilestoneSum: isMilestoneSum)
        if let achieved = highlightProgress() {
            background.image = achieved
        }
        if let isCorrect {
            if (cellTotal - 1) - questionIndex == rowNumber {
                background.image = highlightQuestion(isCorrect: isCorrect)
            }
        }
        background.clipsToBounds = true
        
        questionLabel.font = UIFont(name: "Gilroy-Regular", size: 20)
        questionLabel.textColor = .white
        questionLabel.textAlignment = .left
        questionLabel.text = "Вопрос " + String(cellTotal - rowNumber)
        
        sumLabel.font = UIFont(name: "Gilroy-Regular", size: 20)
        sumLabel.textColor = .white
        sumLabel.textAlignment = .right
        sumLabel.text = sum
        
        contentView.addSubview(background)
        contentView.addSubview(questionLabel)
        contentView.addSubview(sumLabel)
        contentView.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            questionLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: background.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            sumLabel.leadingAnchor.constraint(equalTo: background.centerXAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20),
            sumLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor)
        ])
        
        
    }
    //возвращает свой цвет для каждой ячейки в таблице результатов
    private func calculateBackground(rowNumber: Int, isMilestoneSum: Bool) -> UIImage {
        
        if rowNumber == 0 {
            return UIImage(imageLiteralResourceName: "Rectangle 4")
        } else if isMilestoneSum {
            return UIImage(imageLiteralResourceName: "Rectangle 1")
        } else {
            return UIImage(imageLiteralResourceName: "Rectangle 2")
        }
        
    }
    //подсвечивает ячейку с текущим вопросом верно/неверно
    private func highlightQuestion(isCorrect: Bool) -> UIImage {
        if isCorrect {
            return UIImage(imageLiteralResourceName: "Rectangle 3")
        } else {
            return UIImage(imageLiteralResourceName: "Rectangle 5")
        }
    }
    
    private func highlightProgress() -> UIImage? {
        if didPass {
            return UIImage(imageLiteralResourceName: "Rectangle 3")
        }  else {
            return nil
        }
    }
   
}
