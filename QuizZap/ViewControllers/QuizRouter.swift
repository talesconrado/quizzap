//  
//  QuizRouter.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

protocol QuizRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol QuizDataPassing {
    var dataStore: QuizDataStore? { get }
}

class QuizRouter: QuizRoutingLogic, QuizDataPassing {
    weak var viewController: QuizViewController?
    var dataStore: QuizDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //      let destinationVC = segue.destination as! SomewhereViewController
    //      var destinationDS = destinationVC.router!.dataStore!
    //      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //      let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //      let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //      var destinationDS = destinationVC.router!.dataStore!
    //      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //      navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: QuizViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: QuizDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
