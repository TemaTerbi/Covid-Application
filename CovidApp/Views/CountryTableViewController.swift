//
//  CountryTableViewController.swift
//  CovidApp
//
//  Created by deniss den on 21.06.2022.
//

import UIKit

class CountryTableViewController: UIViewController {
    
    private let tableView = UITableView.init(frame: .zero)
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCounryies: [Countries] = []
    private var isSearhcBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearhcBarIsEmpty
    }

    private let country = DataService.shared.arrayCountries
    
    class TableViewCell: UITableViewCell {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .systemGray5
        self.title = "Страны"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите название страны"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        
        addSubviews()
        updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (contex) in
            self.updateLayout(with: size)
        }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
      filteredCounryies = country.filter { (country: Countries) -> Bool in
          return country.country!.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }

}

extension CountryTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCounryies.count
          }
        return DataService.shared.arrayCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let country: Countries
          if isFiltering {
              country = filteredCounryies[indexPath.row]
          } else {
              country = DataService.shared.arrayCountries[indexPath.row]
          }
        cell.textLabel?.text = country.country
        return cell
    }
}

extension CountryTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country: Countries
        if isFiltering {
            country = filteredCounryies[indexPath.row]
            let selectedIso = country.iso2
            let selectedName = country.country
            UserDefaults.standard.set(selectedIso, forKey: "selectIso")
            UserDefaults.standard.set(selectedName, forKey: "countryName")
            DataService.shared.boolLoop = true
            DataService.shared.items = []
        } else {
            country = DataService.shared.arrayCountries[indexPath.row]
            let selectedIso = country.iso2
            let selectedName = country.country
            UserDefaults.standard.set(selectedIso, forKey: "selectIso")
            UserDefaults.standard.set(selectedName, forKey: "countryName")
            DataService.shared.boolLoop = true
            DataService.shared.items = []
        }
        dismiss(animated: true)
    }
}

extension CountryTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
