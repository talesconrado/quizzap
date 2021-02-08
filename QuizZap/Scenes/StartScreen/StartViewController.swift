//  
//  StartViewController.swift
//  QuizZap
//
//  Created by Tales Conrado on 08/02/21.
//

import UIKit

protocol StartDisplayLogic: AnyObject {
    // func displaySomething(viewModel: Start.Something.ViewModel)
}

class StartViewController: UIViewController, StartDisplayLogic {
    var interactor: StartBusinessLogic?
    var router: (StartRoutingLogic & StartDataPassing)?

    @IBOutlet var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .purpleBG
        }
    }
    @IBOutlet weak var questionsCard: UIView! {
        didSet {
            questionsCard.layer.cornerRadius = 12
            questionsCard.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        }
    }
    @IBOutlet weak var questionsTextField: UITextField! {
        didSet {
            questionsTextField.backgroundColor = .clear
            questionsTextField.textColor = .orangePrimary
            questionsTextField.font = .systemFont(ofSize: 28, weight: .bold)
            questionsTextField.text = "10"
            questionsTextField.borderStyle = .none
        }
    }
    @IBOutlet weak var difficultyCard: UIView! {
        didSet {
            difficultyCard.layer.cornerRadius = 12
            difficultyCard.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            difficultyCard.layer.borderWidth = 2
            difficultyCard.layer.borderColor = UIColor.systemIndigo.cgColor
        }
    }
    @IBOutlet weak var difficultyTextField: UITextField! {
        didSet {
            difficultyTextField.backgroundColor = .clear
            difficultyTextField.textColor = .orangePrimary
            difficultyTextField.font = .systemFont(ofSize: 28, weight: .bold)
            difficultyTextField.text = "Fácil"
            difficultyTextField.borderStyle = .none
        }
    }
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.backgroundColor = .orangePrimary
            startButton.layer.cornerRadius = 30
            startButton.layer.shadowColor = UIColor.orangePrimary.cgColor
            startButton.layer.shadowRadius = 12
            startButton.layer.shadowOpacity = 0.5
            startButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    @IBOutlet weak var bgSquare: UIView! {
        didSet {
            bgSquare.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var bgSquare2: UIView! {
        didSet {
            bgSquare2.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var bgSquare3: UIView! {
        didSet {
            bgSquare3.layer.cornerRadius = 20
        }
    }
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
        let interactor = StartInteractor()
        let presenter = StartPresenter()
        let router = StartRouter()
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
    //func displaySomething(viewModel: Start.Something.ViewModel) {
    //}
}
