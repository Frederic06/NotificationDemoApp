//
//  TitleCellViewModelTest.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 06/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

import Foundation

import XCTest
@testable import NotificationDemoApp

final class TitleCellViewModelTest: XCTestCase {
    
    func testGivenATitleCellViewModel_WhenConfigure_ThenPropertiesAreCorrectlyReturned() {
        
        let delegate = MockTitleCellViewDelegate()
        let hashtag = "rugby"
        let switchState = false
        let switchHidden = true
        let viewModel = TitleCellViewModel(delegate: delegate, hashTag: hashtag, switchState: switchState, switchHidden: switchHidden)
        
        let expectation1 = self.expectation(description: "returned hashtagLabel")
        let expectation2 = self.expectation(description: "returned switchTitle")
    
        let expectation3 = self.expectation(description: "returned hideLocation")
        
        viewModel.hashtagLabel = { hashtag in
            XCTAssertEqual(hashtag, "Recent tweets for : #rugby")
            expectation1.fulfill()
        }
        
        viewModel.switchTitle = { text in
            XCTAssertEqual(text, "Would you search around you?")
            expectation2.fulfill()
        }
        viewModel.hideLocation = { text in
            XCTAssertEqual(text, "true")
            expectation3.fulfill()
        }
        
        
        viewModel.configure()
        viewModel.clickedOnLocationSwitch()
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
}



fileprivate final class MockTitleCellViewDelegate: TitleCellDelegate {
    func didPressHashTagList() {
    }
    
    func didPressFilterLocation() {
    }
    
    func didPressUnFilterLocation() {
    }
    
    
}
