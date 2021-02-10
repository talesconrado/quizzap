//  
//  StartRouter.swift
//  QuizZap
//
//  Created by Tales Conrado on 08/02/21.
//

import UIKit

protocol StartRoutingLogic {
    func routeToQuiz()
}

protocol StartDataPassing {
    var dataStore: StartDataStore? { get }
}

class StartRouter: StartRoutingLogic, StartDataPassing {
    weak var viewController: StartViewController?
    var dataStore: StartDataStore?

    // MARK: Routing

    func routeToQuiz() {
        let destinationVC = QuizViewController(shouldSetupScene: true)
        var destinationDS = destinationVC.router!.dataStore!
        passQuizRequest(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToSomewhere(source: StartViewController, destination: QuizViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: Passing data

    func passQuizRequest(source: StartDataStore, destination: inout QuizDataStore) {
        destination.numberOfQuestions = source.numberOfQuestions
        destination.difficultyLevel = source.difficultyLevel
    }
}
