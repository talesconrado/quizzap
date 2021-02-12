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
    let difficultyStrings: [String] = ["Fácil", "Médio", "Difícil"]

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
            questionsTextField.keyboardType = .numberPad
            questionsTextField.layer.cornerRadius = 12
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
            difficultyTextField.tintColor = .clear
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
    
    lazy var difficultyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        picker.tag = 1
        return picker
    }()
    
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
        let router = StartRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        setupButton()
        setupDismiss()
    }

    // MARK: Display logic
    private func setupPicker() {
        difficultyTextField.inputView = difficultyPicker
        difficultyPicker.selectRow(0, inComponent: 0, animated: false)
        interactor?.didSelectDifficulty(.easy)
        questionsTextField.delegate = self
    }
    
    private func setupButton() {
        startButton.addTarget(self, action: #selector(goToQuizScreen), for: .touchUpInside)
    }
    
    @objc private func goToQuizScreen() {
        if checkQuestionsNumber() {
            router?.routeToQuiz()
        }
    }
    
    private func setupDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditingText))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func endEditingText() {
        view.endEditing(false)
    }
    
    func checkQuestionsNumber() -> Bool {
        if let stringValue = questionsTextField.value(forKey: "text") as? String,
           let intValue = Int(stringValue),
           intValue < 10 || intValue > 20 {
            animateWrongNumber()
            return false
        }
        
        return true
    }
    
    private func animateWrongNumber() {
        UIView.animate(withDuration: 1, delay: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.questionsTextField.backgroundColor = UIColor.wrongBG.withAlphaComponent(0.8)
        }) { (_) in
            UIView.animate(withDuration: 1) {
                self.questionsTextField.backgroundColor = UIColor.wrongBG.withAlphaComponent(0.2)
            }
        }
    }
}

extension StartViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficultyStrings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        difficultyTextField.text = difficultyStrings[row]
        var difficulty: Difficulty = .easy
        
        switch row {
        case 0:
            difficulty = .easy
        case 1:
            difficulty = .medium
        default:
            difficulty = .hard
        }
        
        interactor?.didSelectDifficulty(difficulty)
    }
}

extension StartViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        questionsTextField.backgroundColor = .clear
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        interactor?.didSelectNumberOfQuestions(Int(textField.text ?? "10") ?? 10)
    }
}
