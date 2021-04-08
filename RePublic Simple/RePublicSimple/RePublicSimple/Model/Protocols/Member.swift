//
//  Member.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/1/21.
//

import Foundation

protocol Member {
    var id: String { get }
    var name: String { get }
    var state: String { get }
    var party: Party { get }
    var title: String { get }
}
