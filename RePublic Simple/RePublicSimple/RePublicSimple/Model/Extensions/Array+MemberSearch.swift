//
//  Array+MemberSearch.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/8/21.
//

import Foundation

extension Array where Element == Member {
    func matching(_ text: String?) -> [Member] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.name.contains(text) || $0.state.contains(text)
            }
        } else {
            return self
        }
    }
}
