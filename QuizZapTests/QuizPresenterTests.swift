//
//  QuizPresenterTests.swift
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

class QuizPresenterTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: QuizPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupQuizPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupQuizPresenter()
    {
        sut = QuizPresenter()
    }
    
    // MARK: Test doubles
    
    class QuizDisplayLogicSpy: QuizDisplayLogic {
        func displayScore(score: Int, total: Int) {
            
        }
        
        // TODO: Test
        func displayScore(score: Int) {
            
        }
        
        var setupViewCalled = false
    
        func displayQuestionAndAnswers(viewModel: Quiz.ViewModel) {
            setupViewCalled = true
        }
        
    }
    
    // MARK: Tests
    
      func testSetupView()
      {
        // Given
        let spy = QuizDisplayLogicSpy()
        sut.displayDelegate = spy
        let question = Question(category: "",
                                type: .multiple,
                                difficulty: .easy,
                                question: "Q1",
                                correctAnswer: "A",
                                incorrectAnswers: ["B", "C"])
        
        let response = Quiz.Response(question: question, index: 0)
    
        // When
        sut.didLoadQuestions(response: response)
    
        // Then
        XCTAssertTrue(spy.setupViewCalled, "presentSomething(response:) should ask the view controller to display the result")
      }
}
