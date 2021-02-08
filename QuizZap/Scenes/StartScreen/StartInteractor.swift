//  
//  StartInteractor.swift
//  QuizZap
//
//  Created by Tales Conrado on 08/02/21.
//

import Foundation

protocol StartBusinessLogic {
}

protocol StartDataStore {
}

class StartInteractor: StartBusinessLogic, StartDataStore {
    var presenter: StartPresentationLogic?
    var worker: StartWorker?
}
