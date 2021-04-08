//
//  CodingKeys.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/8/21.
//

import Foundation

enum CodingKeys: CodingKey {
    case status
    case copyright
    case results
    
    enum ResultsKeys: CodingKey {
        case congress
        case chamber
        case num_results
        case offset
        case members
        
        enum MemberKeys: CodingKey {
            case id
            case name
            case state
            case party
            case title
            case district
            case seniority
        }
    }
}
