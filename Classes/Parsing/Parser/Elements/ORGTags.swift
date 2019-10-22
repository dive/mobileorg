//
//  ORGTags.swift
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

class ORGTags: ORGElement {
    let originalString: String
    static var regex: String = ###"\s(:(?:[@\w\.]+:)+)$"###
    var description: String { return "TAGS: \(tags?.joined(separator: "|") ?? "no tags")" }

    private(set) var tagsRange: Range<String.Index>?

    var tags: [String]?

    init(string: String) {
        self.originalString = string
        self.parse()
    }

    private func parse() {
        guard let match = self.matches?.first else { fatalError("Cannot extract a match from the regex.") }
        self.tags = {
            guard let range = Range(match.range(at: 1), in: self.originalString) else { return nil }
            self.tagsRange = range
            return String(self.originalString[range]).split(separator: ":").map { String($0) }
        }()
    }
}

