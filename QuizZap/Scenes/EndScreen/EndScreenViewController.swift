//  
//  EndScreenViewController.swift
//  QuizZap
//
//  Created by Tales Conrado on 10/02/21.
//

import UIKit

protocol EndScreenDisplayLogic: AnyObject {
    func displayScores(viewModel: EndScreen.ViewModel)
}

class EndScreenViewController: UIViewController, EndScreenDisplayLogic {
    var interactor: EndScreenBusinessLogic?
    var router: (EndScreenRoutingLogic & EndScreenDataPassing)?
    @IBOutlet var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .purpleBG
        }
    }
    
    @IBOutlet weak var screenTitleLabel: UILabel! {
        didSet {
            screenTitleLabel.textColor = .yellowTitle
        }
    }
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
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
    
    @IBOutlet weak var restartButton: UIButton! {
        didSet {
            restartButton.backgroundColor = .orangePrimary
            restartButton.layer.cornerRadius = 30
            restartButton.layer.shadowColor = UIColor.orangePrimary.cgColor
            restartButton.layer.shadowRadius = 12
            restartButton.layer.shadowOpacity = 0.5
            restartButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            restartButton.addTarget(self, action: #selector(popToRoot), for: .touchUpInside)
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
        interactor?.getScores()
    }

    // MARK: Display logic
    func displayScores(viewModel: EndScreen.ViewModel) {
        totalScoreLabel.text = "Você acertou \(viewModel.currentScore) de \(viewModel.currentTotal)."
        highestScoreLabel.text =
            "Seu maior score é \(viewModel.highestScore ?? Double(viewModel.currentScore))/"
         + "\(viewModel.highestScoreTotal ?? Double(viewModel.currentTotal))"
        
        percentageLabel.text = "Taxa de acertos de \(viewModel.hitRate)%"
    }
    
    @objc private func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
