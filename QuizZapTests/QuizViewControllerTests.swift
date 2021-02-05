//
//  QuizViewControllerTests.swift
//  QuizZap
//
//  Created by Tales Conrado on 03/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import QuizZap
import XCTest

class QuizViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: QuizViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupQuizViewController()
    }
    
    override func tearDown()
    {
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupQuizViewController() {
        sut = QuizViewController()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class QuizBusinessLogicSpy: QuizBusinessLogic {
        var getNextQuestionCalled = false

        func getNextQuestion() {
            getNextQuestionCalled = true
        }
    }
    
    // MARK: Tests

    func testDisplayHeader() {
        // Given
        let viewModel = Quiz.ViewModel(correctAnswerIndex: 1,
                                       answersList: ["A", "B", "C"],
                                       questionText: "Q1",
                                       category: "Science",
                                       type: .multiple,
                                       difficulty: .easy)
        
        // When
        loadView()
        sut.setupHeader(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.questionHeader.text, "Q1", "displaySomething(viewModel:) should update the name text field")
    }
    
    func testLoadingTableView() {
        
        let viewModel = Quiz.ViewModel(correctAnswerIndex: 1,
                                       answersList: ["A", "B", "C"],
                                       questionText: "Q1",
                                       category: "Science",
                                       type: .multiple,
                                       difficulty: .easy)
        
        sut.displayQuestionAndAnswers(viewModel: viewModel)
        loadView()

        sleep(1)
        
        XCTAssertEqual("A", sut.alternativesTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text)
    }
    
    func testSetupScene() {
        let newInitiatedController = QuizViewController(shouldSetupScene: true)
        
        XCTAssertNotNil(newInitiatedController.router)
        XCTAssertNotNil(newInitiatedController.interactor)
    }
    
    func testCalledGetNextQuestion() {
        let spy = QuizBusinessLogicSpy()
        sut.interactor = spy
        sut.getQuestion()
        
        XCTAssertTrue(spy.getNextQuestionCalled)
    }
}