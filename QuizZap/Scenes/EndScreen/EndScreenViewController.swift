//  
//  EndScreenViewController.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import UIKit

protocol EndScreenDisplayLogic: AnyObject {
    // func displaySomething(viewModel: EndScreen.Something.ViewModel)
}

class EndScreenViewController: UIViewController, EndScreenDisplayLogic {
    var interactor: EndScreenBusinessLogic?
    var router: (EndScreenRoutingLogic & EndScreenDataPassing)?

    // MARK: Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
        setupScene()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setupScene() {
        let viewController = self
        let interactor = EndScreenInteractor()
        let presenter = EndScreenPresenter()
        let router = EndScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.displayDelegate = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Display logic
    //func displaySomething(viewModel: EndScreen.Something.ViewModel) {
    //}
}
