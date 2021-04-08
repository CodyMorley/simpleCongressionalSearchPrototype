//
//  Senator.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/1/21.
//

import Foundation

struct Senator: Decodable, Member {
    var id: String
    var name: String
    var state: String
    var party: Party
    var title: String
    let seniority: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: CodingKeys.ResultsKeys.self, forKey: .results)
        let memberContainer = try resultsContainer.nestedContainer(keyedBy: CodingKeys.ResultsKeys.MemberKeys.self, forKey: .members)
        
        let decodedID = try memberContainer.decode(String.self, forKey: .id)
        let decodedName = try memberContainer.decode(String.self, forKey: .name)
        let decodedState = try memberContainer.decode(String.self, forKey: .state)
        let partyString = try memberContainer.decode(String.self, forKey: .party)
        let decodedTitle = try memberContainer.decode(String.self, forKey: .title)
        let decodedSeniority = try memberContainer.decode(String.self, forKey: .seniority)
        
        id = decodedID
        name = decodedName
        state = decodedState
        title = decodedTitle
        seniority = decodedSeniority
        
        if let decodedParty = Party(rawValue: partyString) {
            party = decodedParty
        } else {
            party = .none
        }
    }
}
