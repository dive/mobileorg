//
//  ORGKeyword.swift
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

// With the exception of clocks, headlines, inlinetasks, items, node properties, planning, property drawers, sections, and table rows, every other element type can be assigned attributes.
// This is done by adding specific keywords, named “affiliated keywords”, just above the element considered, no blank line allowed.

// Affiliated keywords are built upon one of the following patterns:
// #+KEY: VALUE
// #+KEY[OPTIONAL]: VALUE
// #+ATTR_BACKEND: VALUE

// KEY is either “CAPTION”, “HEADER”, “NAME”, “PLOT” or “RESULTS” string.
// BACKEND is a string constituted of alpha-numeric characters, hyphens or underscores.
// OPTIONAL and VALUE can contain any character but a new line. Only “CAPTION” and “RESULTS” keywords can have an optional value.
// An affiliated keyword can appear more than once if KEY is either “CAPTION” or “HEADER” or if its pattern is “#+ATTR_BACKEND: VALUE”.
// “CAPTION”, “AUTHOR”, “DATE” and “TITLE” keywords can contain objects in their value and their optional value, if applicable.

public final class ORGKeyword: ORGElement {
    public var originalString: String
    public static var regex: String = ###"#\+{1}((?:\w)+(?:\[\w+\])?)?: (.*)+"###
    public var description: String { return "KEYWORD: \(self.key ?? "Empty") : \(self.value ?? "Empty")" }

    public var key: String?
    public var value: String?

    public init(string: String) {
        self.originalString = string
        self.parse()
    }

    private func parse() {
        guard let match = self.matches?.first else { fatalError("Cannot extract a match from the regex \n\(self.originalString)") }
        self.key = {
            guard let range = Range(match.range(at: 1), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
        self.value = {
            guard let range = Range(match.range(at: 2), in: self.originalString) else { return nil }
            return String(self.originalString[range])
        }()
        print(self)
    }

}

