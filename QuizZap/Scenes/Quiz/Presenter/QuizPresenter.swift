//  
//  QuizPresenter.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

protocol QuizPresentationLogic {
    func didLoadQuestions(response: Quiz.Response)
    func quizEnded(score: Int)
}

class QuizPresenter: QuizPresentationLogic {
    weak var displayDelegate: QuizDisplayLogic?
    
    var currentRawQuestion: Quiz.Response?
    
    func didLoadQuestions(response: Quiz.Response) {
        self.currentRawQuestion = response
        guard let converter = responseToViewModel(response: currentRawQuestion) else { return }
        displayDelegate?.displayQuestionAndAnswers(viewModel: converter)
    }
    
    func quizEnded(score: Int) {
        displayDelegate?.displayScore(score: score)
    }
    
    private func responseToViewModel(response: Quiz.Response?) -> Quiz.ViewModel? {
        guard let response = response else { return nil }
        
        var answersList = [response.question.correctAnswer]
        response.question.incorrectAnswers.forEach({ answersList.append($0) })
    
        // Randomizing
        answersList = answersList.shuffled()
        let correctIndex = answersList.firstIndex(of: response.question.correctAnswer)!
        
        let viewModel = Quiz.ViewModel(correctAnswerIndex: correctIndex,
                                       answersList: answersList,
                                       questionText: response.question.question,
                                       category: response.question.category,
                                       type: response.question.type,
                                       difficulty: response.question.difficulty)
        
        return viewModel
    }
}
