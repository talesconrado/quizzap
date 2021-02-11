//  
//  EndScreenPresenter.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import UIKit

protocol EndScreenPresentationLogic {
    func sendScores(viewModel: EndScreen.ViewModel)
}

class EndScreenPresenter: EndScreenPresentationLogic {
    weak var displayDelegate: EndScreenDisplayLogic?
    
    func sendScores(viewModel: EndScreen.ViewModel) {
        displayDelegate?.displayScores(viewModel: viewModel)
    }
}
