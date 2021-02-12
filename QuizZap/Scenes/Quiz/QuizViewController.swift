//  
//  QuizViewController.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

protocol QuizDisplayLogic: AnyObject {
    func displayQuestionAndAnswers(viewModel: Quiz.ViewModel)
    func displayScore(score: Int, total: Int)
}

class QuizViewController: UIViewController, QuizDisplayLogic {
    var interactor: QuizBusinessLogic?
    var router: (QuizRoutingLogic & QuizDataPassing)?
    @IBOutlet var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .purpleBG
        }
    }
    @IBOutlet weak var questionHeader: UILabel!
    @IBOutlet weak var questionBackground: UIView! {
        didSet {
            questionBackground.backgroundColor = .purpleHeader
            questionBackground.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var alternativesTableView: UITableView! {
        didSet {
            alternativesTableView.tableFooterView = UIView()
            alternativesTableView.separatorStyle = .none
            alternativesTableView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var nextQuestionButton: UIButton! {
        didSet {
            nextQuestionButton.backgroundColor = .orangePrimary
            nextQuestionButton.layer.cornerRadius = 30
            nextQuestionButton.layer.shadowColor = UIColor.orangePrimary.cgColor
            nextQuestionButton.layer.shadowRadius = 12
            nextQuestionButton.layer.shadowOpacity = 0.5
            nextQuestionButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            nextQuestionButton.isEnabled = false
        }
    }
    @IBOutlet weak var currentQuestionNumber: UILabel! {
        didSet {
            currentQuestionNumber.textColor = .yellowTitle
        }
    }
    
    var currentSelectedIndex: Int? {
        didSet {
            nextQuestionButton.isEnabled = true
        }
    }
    
    var viewModel: Quiz.ViewModel?
    
    // MARK: Lifecycle
    init(shouldSetupScene: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        if shouldSetupScene { setupScene() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupScene() {
        let viewController = self
        let interactor = QuizInteractor()
        let presenter = QuizPresenter()
        let router = QuizRouter()
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
        alternativesTableView.delegate = self
        alternativesTableView.dataSource = self
        loadingAlert {
            self.interactor?.loadQuestions()
        }
        alternativesTableView.register(QuestionCell.self, forCellReuseIdentifier: "cell")
        nextQuestionButton.addTarget(self, action: #selector(didPressNextQuestionButton), for: .touchUpInside)
    }
    
    // MARK: Display logic
    func setupHeader(viewModel: Quiz.ViewModel) {
        questionHeader.text = viewModel.questionText
        currentQuestionNumber.text = String(viewModel.number)
    }
    
    func displayQuestionAndAnswers(viewModel: Quiz.ViewModel) {
        self.viewModel = viewModel
        endLoading()
        reloadContent()
    }
    
    func getQuestion() {
        interactor?.getNextQuestion()
    }
    
    func displayScore(score: Int, total: Int) {
        router?.routeToScoresScreen()
    }
    
    private func reloadContent() {
        DispatchQueue.main.async {
            self.questionHeader.text = self.viewModel?.questionText.htmlAttributedString?.string
            self.currentQuestionNumber.text = "Questão \(self.viewModel?.number ?? 1)"
            self.alternativesTableView.reloadData()
            self.dismiss(animated: false, completion: nil)
            self.nextQuestionButton.isEnabled = false
        }
    }
    
    private func loadingAlert(completion: @escaping (() -> Void)) {
        questionHeader.isHidden = true
        questionBackground.isHidden = true
        currentQuestionNumber.isHidden = true
        let alert = UIAlertController(title: nil, message: "Loading questions...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: completion)
    }
    
    private func endLoading() {
        DispatchQueue.main.async {
            self.questionHeader.isHidden = false
            self.questionBackground.isHidden = false
            self.currentQuestionNumber.isHidden = false
        }
    }
    
    @objc func didPressNextQuestionButton() {
        
        guard let currentSelectedIndex = currentSelectedIndex else {
            
            return
        }
        
        let selectedAnswer = IndexPath(row: currentSelectedIndex, section: 0)
        let cell = alternativesTableView.cellForRow(at: selectedAnswer) as? QuestionCell
        
        if selectedAnswer.row == viewModel?.correctAnswerIndex {
            interactor?.rightAnswer()
            cell?.styleRightAnswer()
        } else {
            cell?.styleWrongAnswer()
            let indexPath = IndexPath(row: viewModel?.correctAnswerIndex ?? 0, section: 0)
            let rightCell = alternativesTableView.cellForRow(at: indexPath) as? QuestionCell
            rightCell?.showAsRightAnswer()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.interactor?.getNextQuestion()
        }
    }
}

// MARK: TableView Methods

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.allowsSelection = true
        return viewModel?.answersList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QuestionCell()
        let text = viewModel?.answersList[indexPath.row].htmlAttributedString?.string
        
        if text!.isEmpty {
            tableView.isHidden = true
        } else {
            cell.questionLabel.text = viewModel?.answersList[indexPath.row].htmlAttributedString?.string
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? QuestionCell
        selectedNewAnswer(index: indexPath.row)
        cell?.styleSelected()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? QuestionCell
        cell?.styleDeselect()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func selectedNewAnswer(index: Int) {
        currentSelectedIndex = index
    }

}
