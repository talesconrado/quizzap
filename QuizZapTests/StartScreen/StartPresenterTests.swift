//
//  StartPresenterTests.swift
//  QuizZap
//
//  Created by Tales Conrado on 12/02/21.

@testable import QuizZap
import XCTest

class StartPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: StartPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupStartPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupStartPresenter()
  {
    sut = StartPresenter()
  }
  
  // MARK: Test doubles
  
  class StartDisplayLogicSpy: StartDisplayLogic
  {
    var displaySomethingCalled = false
    
    func displaySomething(viewModel: Start.Something.ViewModel)
    {
      displaySomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testPresentSomething()
  {
    // Given
    let spy = StartDisplayLogicSpy()
    sut.displayDelegate = spy
    let response = Start.Something.Response()
    
    // When
    
    // Then
    XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}
