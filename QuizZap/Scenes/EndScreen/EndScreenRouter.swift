//  
//  EndScreenRouter.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import UIKit

protocol EndScreenRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol EndScreenDataPassing {
    var dataStore: EndScreenDataStore? { get }
}

class EndScreenRouter: EndScreenRoutingLogic, EndScreenDataPassing {
    weak var viewController: EndScreenViewController?
    var dataStore: EndScreenDataStore?

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

    //func navigateToSomewhere(source: EndScreenViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: EndScreenDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
