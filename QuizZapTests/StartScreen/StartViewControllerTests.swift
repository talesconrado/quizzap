//
//  StartViewControllerTests.swift
//  QuizZap
//
//  Created by Tales Conrado on 12/02/21.

@testable import QuizZap
import XCTest

class StartViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: StartViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupStartViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupStartViewController()
    {
        sut = StartViewController()
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class StartBusinessLogicSpy: StartBusinessLogic
    {
        func didSelectDifficulty(_ difficulty: Difficulty) {
            
        }
        
        func didSelectNumberOfQuestions(_ numberOfQuestions: Int) {
            
        }
    }
    
    // MARK: Tests
    
    func testSelectionOfLessThanMinimumQuestionNumber()
    {
        // Given
        _ = sut.view
        
        sut.questionsTextField.text = "9"
        
        // When
        loadView()
        
        // Then
        XCTAssertFalse(sut.checkQuestionsNumber())
    }
    
    func testSelectionOfMoreThanMaximumQuestionNumber()
    {
        // Given
        _ = sut.view
        
        sut.questionsTextField.text = "30"
        
        // When
        loadView()
        
        // Then
        XCTAssertFalse(sut.checkQuestionsNumber())
    }
    
    func testSelectionOfAllowedQuestionNumber()
    {
        // Given
        _ = sut.view
        
        sut.questionsTextField.text = "15"
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(sut.checkQuestionsNumber())
    }
}
