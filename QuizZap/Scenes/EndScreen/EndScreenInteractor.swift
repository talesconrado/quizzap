//  
//  EndScreenInteractor.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import Foundation

protocol EndScreenBusinessLogic {
    func getScores()
}

protocol EndScreenDataStore {
    var numberOfQuestions: Int { get set }
    var score: Int { get set }
}

class EndScreenInteractor: EndScreenBusinessLogic, EndScreenDataStore {
    var presenter: EndScreenPresentationLogic?
    var worker: QuizCoreDataWorker = QuizCoreDataWorker()
    
    var numberOfQuestions: Int = 10
    
    var score: Int = 0
    
    var highestScore: Score?
    
    init() {
    }
    
    private func saveScore() {
        worker.save(points: score, total: numberOfQuestions)
    }
    
    private func getHighestScore() {
        worker.loadScores()
        highestScore = worker.scores.first
    }
    
    func getScores() {
        saveScore()
        getHighestScore()
        let hitRate: Double = Double( (Double(score) / Double(numberOfQuestions)) * 100)
        let viewModel = EndScreen.ViewModel(highestScore: highestScore?.points,
                                            highestScoreTotal: highestScore?.total,
                                            hitRate: hitRate,
                                            currentScore: score,
                                            currentTotal: numberOfQuestions)
        
        presenter?.sendScores(viewModel: viewModel)
    }
}
