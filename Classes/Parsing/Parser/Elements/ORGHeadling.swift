//
//  ORGHeadling.swift
//  MobileOrg
//
//  Created by Artem Loenko on 21/10/2019.
//  Copyright © 2019 Artem Loenko. All rights reserved.
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//

import Foundation

public class ORGHeadline: ORGElement {
    // STARS KEYWORD PRIORITY TITLE TAGS
    // 1 : Stars - required
    // 2 : Keyword - optional
    // 3 : Priority - optional
    // 4 : Title - optional (?)
    // 5 : Tags - optional (Not part of the regex, handle separately)
    public static let regex: String = ###"(\*+){1} *(\b[A-Z]+\b)? *(\[\#.+\])? *(.*)? *(\:.*\:)?"###
    enum Groups: Int {
        case stars = 1
        case keyword
        case priority
        case title
//        case tags
    }

    public var description: String {
        return "HEADING: \([self.stars, self.keyword, self.priority, self.title, self.tags?.description].compactMap { $0 }.joined(separator: "|"))"
    }

    public var stars: String?
    public var keyword: String?
    public var priority: String?
    public var title: String?
    public var tags: ORGTags?

    public let originalString: String

    public init(string: String) {
        self.originalString = string
        self.parse()
    }

    private func parse() {
        guard let match = self.matches?.first else {
            fatalError("Cannot extract a match from the regex.")
        }
        self.stars = {
            guard let range = Range(match.range(at: Groups.stars.rawValue), in: self.originalString) else {
                fatalError("Stars are required for the heading")
            }
            return String(self.originalString[range])
        }()
        self.keyword = {
            guard let range = Range(match.range(at: Groups.keyword.rawValue), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
        self.priority = {
            guard let range = Range(match.range(at: Groups.priority.rawValue), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
        self.title = {
            guard let range = Range(match.range(at: Groups.title.rawValue), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
        // Edge-case, tags extraction separated from the base parsing to avoid collisions
        self.tags = {
            guard let title = self.title, ORGTags.match(string: title) else { return nil }
            let tags = ORGTags(string: title)
            if let tagsRange = tags.tagsRange {
                self.title?.removeSubrange(tagsRange)
                self.title = self.title?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            return tags
        }()
        print(self)
    }
}

