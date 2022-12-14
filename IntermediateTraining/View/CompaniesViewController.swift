//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by huygur on 29.11.2022.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController, CreateNewCompanyDelegate {
    
    

    //MARK: - Variables
    var companies = [Company]()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(handleAddCompany))

        fetchCompanies()
        setupNavigationStyle()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.backgroundColor = UIColor(hexString: "#D6E4E5")
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView() //bland UIView
    }

    //MARK: - Objc functions
    @objc func handleAddCompany() {

        let createCompanyController = CreateCompanyViewController()
        let NavCompanyController = CustomNavigationController(rootViewController: createCompanyController)

        createCompanyController.delegate = self

        present(NavCompanyController, animated: true, completion: nil)
    }

    //MARK: - Functions
    func didAddCompany(company: Company) {
        companies.append(company)

        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)

        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didEditCompany(company: Company) {
        // update tableView
        let row = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }

    func fetchCompanies() {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")

        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            self.tableView.reloadData()
        } catch let fetchErr {
            fatalError("Fetch Request Failed: \(fetchErr)")
        }
    }

    //MARK: - Functions

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        //Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, bool) in
            let company = self.companies[indexPath.row]
            //update array
            self.companies.remove(at: indexPath.row)
            //update table view
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //update core data
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            } catch let saveErr {
                print("failed to delete company", saveErr)
            }
        }
        
        deleteAction.backgroundColor = .red

        //Edit Action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, bool) in
            print("edit")

            //perform edit
            
            let editCompanyController = CreateCompanyViewController()
            editCompanyController.delegate = self
            editCompanyController.company = self.companies[indexPath.row]
            let navController = CustomNavigationController(rootViewController: editCompanyController)
            self.present(navController, animated: true, completion: nil)
        }
        
        editAction.backgroundColor = UIColor(hexString: "#FF9E9E")
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeAction

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
