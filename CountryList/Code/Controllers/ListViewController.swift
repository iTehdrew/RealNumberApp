//
//  ListViewController.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private(set) var tableView: UITableView!
    
    // MARK: - Properties
    private(set) var refreshControl = UIRefreshControl()
    private(set) var countries = [Country]()
    private(set) var searchText: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("countryList_title", comment: "")
        
        let countryNib = UINib(nibName: String(describing: CountryCell.self), bundle: nil)
        tableView.register(countryNib,
                           forCellReuseIdentifier: String(describing: CountryCell.self))
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = NSLocalizedString("countryList_search_placeholder", comment: "")
//        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.definesPresentationContext = true
        search.searchBar.delegate = self
        navigationItem.searchController = search
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 20.0, weight: .medium)]
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        fetchList()
    }

    private func fetchList() {
        
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            fatalError("Can't fetch list")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let countryData = try decoder.decode([Country].self, from: data)
            print(countryData)
            countries = countryData
            refreshControl.endRefreshing()
            tableView.reloadData()
        } catch {
            // show error
            print("Error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Actions
private extension ListViewController {
    
    @IBAction func refreshData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        fetchList()
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchText.isEmpty ? countries.count : countries.filter { $0.name.contains(searchText) }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryCell.self),
                                                       for: indexPath) as? CountryCell else {
                                                        fatalError("Can't init CountryCell")
        }
        
        let countries = searchText.isEmpty ? self.countries : self.countries.filter { $0.name.contains(searchText) }
        let country = countries[indexPath.row]
        
        cell.configure(with: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CountryCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        navigationItem.searchController?.resignFirstResponder()
//        navigationItem.searchController?.searchBar.resignFirstResponder()
//        navigationItem.searchController?.isActive = false
        navigationItem.searchController?.dismiss(animated: false, completion: nil)
        
        performSegue(withIdentifier: "showDetails", sender: self);
    }
}

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
    }
}
