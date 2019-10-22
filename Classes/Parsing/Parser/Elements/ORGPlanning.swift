//
//  ORGPlanning.swift
//  MobileOrg
//
//  Created by Artem Loenko on 22/10/2019.
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

import Foundation

final class ORGPlanning: ORGElement {
    let originalString: String
    static var regex: String = ###"(SCHEDULED|DEADLINE){1}: (<\d{4}-\d{2}-\d{2} \D+(?:\s\d{2}:\d{2})?(?:\s\W+\d+\w)?>)"###
    var description: String { return "PLANNING: \(self.type!) -> \(self.planned!)" }

    var type: String?
    var planned: String?

    init(string: String) {
        self.originalString = string
        self.parse()
    }

    private func parse() {
        guard let match = self.matches?.first else { fatalError("Cannot extract a match from the regex.") }
        self.type = {
            guard let range = Range(match.range(at: 1), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
        self.planned = {
            guard let range = Range(match.range(at: 2), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
    }
}
