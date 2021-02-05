//  
//  QuizViewController.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

protocol QuizDisplayLogic: AnyObject {
    func displayQuestionAndAnswers(viewModel: Quiz.ViewModel)
    func displayScore(score: Int)
}

class QuizViewController: UIViewController, QuizDisplayLogic {
    var interactor: QuizBusinessLogic?
    var router: (QuizRoutingLogic & QuizDataPassing)?
    @IBOutlet var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .white
        }
    }
    @IBOutlet weak var questionHeader: UILabel!
    @IBOutlet weak var alternativesTableView: UITableView! {
        didSet {
            alternativesTableView.tableFooterView = UIView()
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
        loadingAlert()
    }
    
    // MARK: Display logic
    func setupHeader(viewModel: Quiz.ViewModel) {
        questionHeader.text = viewModel.questionText
    }
    
    func displayQuestionAndAnswers(viewModel: Quiz.ViewModel) {
        self.viewModel = viewModel
        reloadContent()
    }
    
    func getQuestion() {
        interactor?.getNextQuestion()
    }
    
    func displayScore(score: Int) {
        alternativesTableView.isHidden = true
        questionHeader.textAlignment = .center
        questionHeader.text = "End of quiz! You got \(score) out of 10."
    }
    
    private func reloadContent() {
        DispatchQueue.main.async {
            self.questionHeader.text = self.viewModel?.questionText.htmlAttributedString?.string
            self.alternativesTableView.reloadData()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func loadingAlert() {
        let alert = UIAlertController(title: nil, message: "Loading questions...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: TableView Methods

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.allowsSelection = true
        return viewModel?.answersList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let text = viewModel?.answersList[indexPath.row].htmlAttributedString?.string
        
        if text!.isEmpty {
            tableView.isHidden = true
        } else {
            cell.textLabel?.text = viewModel?.answersList[indexPath.row].htmlAttributedString?.string
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel?.correctAnswerIndex {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .green
            interactor?.rightAnswer()
        } else {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .red
        }
        tableView.allowsSelection = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getQuestion()
        }
    }
}

extension String {
    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
