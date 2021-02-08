//  
//  QuizModels.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

enum Quiz {
    struct Request {
        let questionNumber: Int
    }

    struct Response {
        let question: Question
    }

    struct ViewModel {
        let correctAnswerIndex: Int
        let answersList: [String]
        let questionText: String
        let category: String
        let type: TypeEnum
        let difficulty: Difficulty
    }
}
