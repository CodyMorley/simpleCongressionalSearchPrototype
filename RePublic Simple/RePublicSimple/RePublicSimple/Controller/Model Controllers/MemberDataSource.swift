//
//  MemberDataSource.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/8/21.
//

import UIKit

class MemberDataSource: NSObject, UITableViewDataSource {
    let fetchController = NetworkingController()
    var members: [Member] {
        return fetchController.members
    }
    var filteredMembers: [Member] {
        if filterText != nil {
            return members.matching(filterText)
        } else {
            return members
        }
    }
    var dataChanged: (() -> Void)?
    var filterText: String? {
        didSet {
            dataChanged?()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath)
        let member = filteredMembers[indexPath.row]
        
        cell.textLabel?.text = member.title + " " + member.name
        cell.detailTextLabel?.text = member.state
        return cell
    }
    
    func getMembers() {
        DispatchQueue.main.async {
            self.fetchController.refresh()
        }
        dataChanged?()
    }
}
