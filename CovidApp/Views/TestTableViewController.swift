//
//  TestTableViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 17.06.2022.
//

import UIKit

class TestTableViewController: UIViewController {
    
    let tableView = UITableView.init(frame: .zero)
    
    class TableViewCell: UITableViewCell {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = self
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
           
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension TestTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    
}
