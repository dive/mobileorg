//
//  ORGElement.swift
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

enum ORGElementType {
    case headline
    case keyword
    case unknown
}

protocol ORGElement: CustomStringConvertible {
    var originalString: String { get }
    var originalStringRange: NSRange { get }
    var regularExpression: NSRegularExpression { get }
    var matches: [NSTextCheckingResult]? { get }
    static var regex: String { get }
    static func match(string: String) -> Bool
}

// Default implementation for common logic
extension ORGElement {
    // FIXME: computed properties are expensive
    var regularExpression: NSRegularExpression {
        do { return try NSRegularExpression(pattern: Self.regex, options: []) }
        catch { fatalError("Cannot compile a regular expression for: \(Self.regex)") }
    }

    var originalStringRange: NSRange {
        return NSRange(self.originalString.startIndex..<self.originalString.endIndex, in: self.originalString)
    }

    var matches: [NSTextCheckingResult]? {
        return self.regularExpression.matches(in: self.originalString, options: [], range: self.originalStringRange)
    }

    static func match(string: String) -> Bool {
        return string.range(of: Self.regex, options: .regularExpression) != nil
    }
}


