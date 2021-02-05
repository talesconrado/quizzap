//
//  QuizInteractorTests.swift
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

class QuizInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: QuizInteractor!

    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupQuizInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup

    func setupQuizInteractor() {
        let worker = QuizAPIWorker()
        sut = QuizInteractor(worker: worker)
    }

    // MARK: Test doubles

    class QuizPresentationLogicSpy: QuizPresentationLogic {
        var loadQuestionsCalled = false

        func didLoadQuestions(response: Quiz.Response) {
            
        }
        
    }

    // MARK: Tests

    func testGetFirstQuestion() {
        // Given
        let spy = QuizPresentationLogicSpy()
        sut.presenter = spy
        let request = Quiz.Request(questionNumber: 0)

        // When
        sleep(3)
        let question = sut.getNextQuestion()
    
        // Then
        XCTAssertNotNil(question)
    }
}
