//
//  Question.swift
//  MillionaireGame
//
//  Created by deshollow on 15.04.2024.
//

import Foundation

struct Question {
    let questionText: String
    let answers: [Answer]
    let correctAnswerIndex: Int
}

struct Answer {
    let text: String
}

