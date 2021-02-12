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
}
