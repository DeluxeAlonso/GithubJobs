//
//  FAQsItemViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 25/01/25.
//

import XCTest
import Combine
@testable import GithubJobs

@MainActor
final class FAQsItemViewModelTests: XCTestCase {

    func testPadding() {
        // Arrange
        let viewModel = FAQsItemViewModel(faq: .init(id: "", title: "", descriptions: []))
        // Act
        let padding = viewModel.padding
        // Assert
        XCTAssertEqual(padding, 16.0)
    }

    func testSubtitlesVerticalSpacing() {
        // Arrange
        let viewModel = FAQsItemViewModel(faq: .init(id: "", title: "", descriptions: []))
        // Act
        let subtitlesVerticalSpacing = viewModel.subtitlesVerticalSpacing
        // Assert
        XCTAssertEqual(subtitlesVerticalSpacing, 8.0)
    }

    func testExpandCollapseStyleConfiguration() {
        // Arrange
        let viewModel = FAQsItemViewModel(faq: .init(id: "", title: "", descriptions: []))
        // Act
        let expandCollapseStyleConfiguration = viewModel.expandCollapseStyleConfiguration
        // Assert
        XCTAssertEqual(expandCollapseStyleConfiguration.expandedIconName, "minus")
        XCTAssertEqual(expandCollapseStyleConfiguration.collapsedIconName, "plus")
        XCTAssertEqual(expandCollapseStyleConfiguration.iconSize, CGSize(width: 16, height: 16))
        XCTAssertEqual(expandCollapseStyleConfiguration.iconTrailingPadding, 16)
        XCTAssertEqual(expandCollapseStyleConfiguration.verticalSpacing, 8)
        XCTAssertEqual(expandCollapseStyleConfiguration.horizontalSpacing, 8)
    }

}
