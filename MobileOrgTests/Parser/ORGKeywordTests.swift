//
//  ORGKeywordTests.swift
//  MobileOrgTests
//
//  Created by Artem Loenko on 21/10/2019.
//  Copyright © 2019 Sean Escriva. All rights reserved.
//

import XCTest
@testable import MobileOrg

class ORGKeywordTests: XCTestCase {

    func test_thatMatchWorksForCorrectKeywords() {
        let keywords = ["#+KEY: VALUE",
                        "#+KEY[OPTIONAL]: VALUE",
                        "#+ATTR_BACKEND: VALUE"]
        keywords.forEach { XCTAssertTrue(ORGKeyword.match(string: $0)) }
    }

    func test_thatMatchIgnoresInCorrectOrVerySimilarKeywords() {
        let keywords = ["#++KEY: VALUE",
                        "#+KEY{OPTIONAL}: VALUE",
                        "#+KEY VALUE",
                        "#KEY: VALUE",
                        "+KEY: VALUE",
                        "#+KEY:",
                        ":KEY: VALUE"]
        keywords.forEach { XCTAssertFalse(ORGKeyword.match(string: $0)) }
    }

    func test_thatParserProducesProperResults() {
        let keyword = "#+TITLE: Awesome Title"
        let sut = ORGKeyword(string: keyword)
        XCTAssertEqual(sut.key, "TITLE")
        XCTAssertEqual(sut.value, "Awesome Title")
    }

}
