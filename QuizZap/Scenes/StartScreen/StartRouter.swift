//  
//  StartRouter.swift
//  QuizZap
//
//  Created by Tales Conrado on 08/02/21.
//

import UIKit

protocol StartRoutingLogic {
    //func routeToQuiz()
}

protocol StartDataPassing {
    var dataStore: StartDataStore? { get }
}

class StartRouter: StartRoutingLogic, StartDataPassing {
    weak var viewController: StartViewController?
    var dataStore: StartDataStore?

    // MARK: Routing

//    func routeToQuiz() {
//      if let segue = segue {
//          let destinationVC = segue.destination as! SomewhereViewController
//          var destinationDS = destinationVC.router!.dataStore!
//          passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      } else {
//          let storyboard = UIStoryboard(name: "Main", bundle: nil)
//          let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//          var destinationDS = destinationVC.router!.dataStore!
//          passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//          navigateToSomewhere(source: viewController!, destination: destinationVC)
//      }
//    }
//
//    // MARK: Navigation
//
//    func navigateToSomewhere(source: StartViewController, destination: QuizViewController) {
//        source.navigationController?.pushViewController(destination, animated: true)
//    }
//
//    // MARK: Passing data
//
//    func passDataToSomewhere(source: StartDataStore, destination: inout QuizDataStore) {
//      destination.name = source.name
//    }
}
