//
//  Representative.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/1/21.
//

import Foundation

struct Representative: Decodable, Member {
    var id: String
    var name: String
    var state: String
    var party: Party
    var title: String
    let district: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: CodingKeys.ResultsKeys.self, forKey: .results)
        let memberContainer = try resultsContainer.nestedContainer(keyedBy: CodingKeys.ResultsKeys.MemberKeys.self, forKey: .members)
        
        let decodedID = try memberContainer.decode(String.self, forKey: .id)
        let decodedName = try memberContainer.decode(String.self, forKey: .name)
        let decodedState = try memberContainer.decode(String.self, forKey: .state)
        let partyString = try memberContainer.decode(String.self, forKey: .party)
        let decodedTitle = try memberContainer.decode(String.self, forKey: .title)
        let decodedDistrict = try memberContainer.decode(String.self, forKey: .district)
        
        id = decodedID
        name = decodedName
        state = decodedState
        title = decodedTitle
        district = decodedDistrict
        
        if let decodedParty = Party(rawValue: partyString) {
            party = decodedParty
        } else {
            party = .none
        }
    }
}
