//
//  ORGTagsTests.swift
//  MobileOrgTests
//
//  Created by Artem Loenko on 21/10/2019.
//  Copyright © 2019 Sean Escriva. All rights reserved.
//

import XCTest
@testable import MobileOrg

class ORGTagsTests: XCTestCase {

    func test_thatMatchWorksForCorrectKeywords() {
        let tags = ["TITLE :one:two:three:",
                    "TITLE :one:@two:three:FOUR:five:",
                    "TITLE :@one:@two:",
                    "TITLE :one:",
                    "TITLE :@one:",
                    "TITLE :with_underscore:"]
        tags.forEach { XCTAssertTrue(ORGTags.match(string: $0)) }
    }

    func test_thatMatchIgnoresInCorrectOrVerySimilarKeywords() {
        let tags = ["TITLE one:two",
                    "TITLE :one:two",
                    "TITLE one:two:",
                    "TITLE @one:@two@"]
        tags.forEach { XCTAssertFalse(ORGTags.match(string: $0), "\($0) is incorrect tags set and has to fail.") }
    }

    func test_thatTagsParsedCorrectly() {
        let tags = ["one", "two", "three", "@four", "five_six"]
        let sut = ORGTags(string: "TITLE :\(tags.joined(separator: ":")):")
        XCTAssertEqual(sut.tags, tags)
    }

}
