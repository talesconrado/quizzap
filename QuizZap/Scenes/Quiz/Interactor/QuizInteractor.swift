//  
//  QuizInteractor.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import Foundation

protocol QuizBusinessLogic {
    func getNextQuestion()
    func rightAnswer()
}

protocol QuizDataStore {
}

class QuizInteractor: QuizBusinessLogic, QuizDataStore {
    var presenter: QuizPresentationLogic?
    var worker: QuizAPIWorker?
    var questionsList: [Question]?
    var currentQuestionIndex: Int = 0
    var score = 0
    
    
    init(worker: QuizAPIWorker? = nil) {
        if let worker = worker {
            self.worker = worker
        } else {
            self.worker = QuizAPIWorker()
        }
        loadQuestions()
    }
    
    private func loadQuestions() {
        worker?.fetchQuestions(quantity: 3, completionHandler: {
            self.questionsList = $0
            let response = self.generateResponseFromQuestion()
            self.presenter?.didLoadQuestions(response: response!)
        })
    }

    func getQuestionAtIndex(request: Quiz.Request) -> Question? {
        return getValueFromIndex(index: request.questionNumber)
    }
    
    func getNextQuestion() {
        let response = generateResponseFromQuestion()
        if response == nil {
            presenter?.quizEnded(score: score)
        } else {
            presenter?.didLoadQuestions(response: response!)
        }
    }
    
    func generateResponseFromQuestion() -> Quiz.Response? {
        guard let list = questionsList else { return nil }
        if list.indices.contains(currentQuestionIndex) {
            let question = list[currentQuestionIndex]
            let response = Quiz.Response(question: question)
            currentQuestionIndex += 1
            return response
        }
        
        return nil
    }
    
    func rightAnswer() {
        score += 1
    }
    
    private func getValueFromIndex(index: Int) -> Question? {
        guard let questions = questionsList else { return nil }
        
        if questions.indices.contains(index) {
            return questions[index]
        }
        
        return nil
    }
}
