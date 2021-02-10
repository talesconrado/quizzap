//  
//  StartInteractor.swift
//  QuizZap
//
//  Created by Tales Conrado on 08/02/21.
//

import Foundation

protocol StartBusinessLogic {
    func didSelectDifficulty(_ difficulty: Difficulty)
    func didSelectNumberOfQuestions(_ numberOfQuestions: Int)
}

protocol StartDataStore {
    var difficultyLevel: Difficulty? { get set }
    var numberOfQuestions: Int? { get set }
}

class StartInteractor: StartBusinessLogic, StartDataStore {
    var difficultyLevel: Difficulty?
    var numberOfQuestions: Int?
    
    var presenter: StartPresentationLogic?
    
    func didSelectDifficulty(_ difficulty: Difficulty) {
        difficultyLevel = difficulty
    }
    
    func didSelectNumberOfQuestions(_ numberOfQuestions: Int) {
        self.numberOfQuestions = numberOfQuestions
    }
}
