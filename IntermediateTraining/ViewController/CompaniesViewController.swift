//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by huygur on 29.11.2022.
//

import UIKit

class CompaniesViewController: UITableViewController, CreateNewCompanyDelegate {
   
    
    var companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Amazon", founded: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(handleAddCompany))
        
        setupNavigationStyle()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.backgroundColor = UIColor(hexString: "#D6E4E5")
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView() //bland UIView
    }
    
    @objc func handleAddCompany() {
        
        let createCompanyController = CreateCompanyViewController()
//        createCompanyController.view.backgroundColor = .green
        
        let NavCompanyController = CustomNavigationController(rootViewController: createCompanyController)
        
        createCompanyController.delegate = self
        
        present(NavCompanyController, animated: true, completion: nil)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#D6E4E5")
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor(hexString: "#497174")
        
        let company = companies[indexPath.row]
        
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
}
