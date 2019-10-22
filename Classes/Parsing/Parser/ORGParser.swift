//
//  ORGParser.swift
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

// TODO:
// - [ ] implement Greater Blocks support;
// - [ ] implement Drawers and Property Drawers support;
// - [ ] implement Dynamic Blocks support;
// - [ ] implement Footnote Definitions support;
// - [ ] implement Inlinetasks support;
// - [ ] implement Plain Lists and Items support;
// - [ ] implement Property Drawers support;
// - [ ] what to do with Tables?
// - [ ] implement Clock, Diary Sexp and Planning support;
// - [ ] implement Comments support;
// - [ ] implement Fixed Width Areas support;
// - [ ] implement Horizontal Rules support;

import Foundation

final class ORGParser {

    private let content: String
    private var document: ORGDocument

    init(content: String) {
        self.content = content
        self.document = ORGDocument()
    }

    func parse() {
        self.content.components(separatedBy: .newlines).forEach { line in
            switch line.orgType {
            case .headline:
                print(ORGHeadline(string: line))
            case .keyword:
                print(ORGKeyword(string: line))
            case .unknown:
                print("Unknown type")
            }
        }
    }
}
