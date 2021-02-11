//  
//  EndScreenModels.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import UIKit

enum EndScreen {
    struct Request {
    }

    struct Response {
    }

    struct ViewModel {
        let highestScore: Double?
        let highestScoreTotal: Double?
        let hitRate: Double
        let currentScore: Int
        let currentTotal: Int
    }
}
