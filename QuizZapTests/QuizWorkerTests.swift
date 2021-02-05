//
//  QuizWorkerTests.swift
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

class QuizWorkerTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: QuizAPIWorker!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupQuizWorker()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupQuizWorker() {
    sut = QuizAPIWorker()
  }
  
  // MARK: Test doubles
  
  // MARK: Tests
  
  func testFetchingQuestions() {
    // Given
    let quantity = 10
    var questionsArray: [Question] = []
    let requestExpectation = expectation(description: "Request should return questions")
    
    // When
    sut.fetchQuestions(quantity: quantity, completionHandler: {
                        questionsArray = $0
        XCTAssertEqual(quantity, questionsArray.count)
        print(questionsArray)
        requestExpectation.fulfill()
    })
    
    // Then
    wait(for: [requestExpectation], timeout: 10.0)
    
  }
}
