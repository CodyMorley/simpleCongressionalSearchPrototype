//
//  SearchTableViewController.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/1/21.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var dataSource = MemberDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        searchSetup()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.filterText = searchController.searchBar.text
    }
    
    private func searchSetup() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find A Member of Congress"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
    private func setupDataSource() {
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        dataSource.getMembers()
        tableView.dataSource = dataSource
    }

}
