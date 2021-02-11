//  
//  QuizRouter.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

protocol QuizRoutingLogic {
    func routeToScoresScreen()
}

protocol QuizDataPassing {
    var dataStore: QuizDataStore? { get }
}

class QuizRouter: QuizRoutingLogic, QuizDataPassing {
    weak var viewController: QuizViewController?
    var dataStore: QuizDataStore?

    // MARK: Routing

    func routeToScoresScreen() {
          let destinationVC = EndScreenViewController()
          var destinationDS = destinationVC.router!.dataStore!
          passDataToSomewhere(source: dataStore!, destination: &destinationDS)
          navigateToSomewhere(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToSomewhere(source: QuizViewController, destination: EndScreenViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToSomewhere(source: QuizDataStore, destination: inout EndScreenDataStore) {
        destination.numberOfQuestions = source.numberOfQuestions!
        destination.score = source.score
    }
}
