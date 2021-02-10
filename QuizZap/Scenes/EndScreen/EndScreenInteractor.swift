//  
//  EndScreenInteractor.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import Foundation

protocol EndScreenBusinessLogic {
}

protocol EndScreenDataStore {
}

class EndScreenInteractor: EndScreenBusinessLogic, EndScreenDataStore {
    var presenter: EndScreenPresentationLogic?
    var worker: EndScreenWorker?
}
