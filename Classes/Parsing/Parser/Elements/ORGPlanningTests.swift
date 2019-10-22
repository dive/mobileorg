//
//  ORGPlanningTests.swift
//  MobileOrgTests
//
//  Created by Artem Loenko on 22/10/2019.
//  Copyright © 2019 Artem Loenko. All rights reserved.
//

import XCTest
@testable import MobileOrg

class ORGPlanningTests: XCTestCase {

    func test_thatMatchWorksForCorrectKeywords() {
        let planning = ["DEADLINE: <2020-01-07 Tue> SCHEDULED: <2019-12-21 Sat>",
                        "DEADLINE: <2020-01-07 Tue>",
                        "SCHEDULED: <2019-12-21 Sat>",
                        "SCHEDULED: <2019-10-23 Wed 08:00 ++1d>",
                        "SCHEDULED: <2019-11-01 Fri ++1m>",
                        "SCHEDULED: <2019-10-26 Sat ++7d>",
                        "SCHEDULED: <2019-10-26 Sat +1y>",
                        "SCHEDULED: <2019-10-23 Wed 08:00>"]
        planning.forEach { XCTAssertTrue(ORGPlanning.match(string: $0)) }
    }

    func test_thatMatchIgnoresInCorrectOrVerySimilarKeywords() {
        let planning = ["DEADLINE: 2020-01-07 Tue SCHEDULED: 2019-12-21 Sat",
                        "DEADLINE <2020-01-07 Tue>",
                        "SCHEDULED::: <2019-12-21 Sat>",
                        "SCHEDULED <2019/10/23 Wed 08:00 ++1d>",
                        "SCHEDULED: <2019 11 01 Fri>",
                        "SCHEDULED: <2019 May 27 Sat>",
                        "SCHEDULED: <2019-10-26 12 +1y>",
                        "ASSIGNED: <2019-10-23 Wed 08:00>"]
        planning.forEach { XCTAssertFalse(ORGPlanning.match(string: $0)) }
    }

    func test_thatParserProducesProperResultsForScheduled() {
        let planning = "SCHEDULED: <2019-12-21 Sat 08:00 +1w>"
        let sut = ORGPlanning(string: planning)
        XCTAssertEqual(sut.type, "SCHEDULED")
        XCTAssertEqual(sut.planned, "<2019-12-21 Sat 08:00 +1w>")
    }

    func test_thatParserProducesProperResultsForDeadline() {
        let planning = "DEADLINE: <2019-12-21 Sat>"
        let sut = ORGPlanning(string: planning)
        XCTAssertEqual(sut.type, "DEADLINE")
        XCTAssertEqual(sut.planned, "<2019-12-21 Sat>")
    }

}
