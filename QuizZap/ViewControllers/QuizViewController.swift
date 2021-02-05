//  
//  QuizViewController.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import UIKit

protocol QuizDisplayLogic: AnyObject {
     func displayQuestionAndAnswers(viewModel: Quiz.ViewModel)
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
    
    private func reloadContent() {
        DispatchQueue.main.async {
            self.questionHeader.text = self.viewModel?.questionText.htmlAttributedString?.string
            self.alternativesTableView.reloadData()
        }
    }
}

// MARK: TableView Methods

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.answersList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel?.answersList[indexPath.row].htmlAttributedString?.string
        return cell
    }
}

extension String {
    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
