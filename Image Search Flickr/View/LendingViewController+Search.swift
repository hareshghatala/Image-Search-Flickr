//
//  LendingViewController+Search.swift
//  Image Search Flickr
//
//  Created by Haresh Ghatala on 2022/12/12.
//

import UIKit

// MARK: - SearchBar Delegate methods

extension LendingViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = true
        searchBar.isSearchResultsButtonSelected = true
        searchHistoryTableView.isHidden = false
        viewModel.fetchSearchHistory()
        searchHistoryTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.isSearchResultsButtonSelected = false
        self.view.endEditing(true)
        searchHistoryTableView.isHidden = true
        performSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    private func performSearch() {
        guard let text = mainSearchBar.text, !text.isEmpty else {
            return
        }
        searchHistoryTableView.isHidden = true
        viewModel.searchOffset = 0
        viewModel.fetchImages(searchText: text, offset: viewModel.searchOffset)
    }
    
}

// MARK: - TableView DataSource & Delegate methods

extension LendingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: searchHistoryCellId) {
            cell = dequeueCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: searchHistoryCellId)
        }
        cell.backgroundColor = .clear
        cell.textLabel?.text = viewModel.searchHistory[indexPath.row]
        
        return cell
    }
    
}

extension LendingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainSearchBar.text = viewModel.searchHistory[indexPath.row]
        self.view.endEditing(true)
        performSearch()
    }
    
}
