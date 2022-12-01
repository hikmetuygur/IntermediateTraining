//
//  CreateCompanyViewController.swift
//  IntermediateTraining
//
//  Created by huygur on 30.11.2022.
//

import UIKit
import CoreData

protocol CreateNewCompanyDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyViewController: UIViewController {
    
    //MARK: - Variables
    
    var delegate: CreateNewCompanyDelegate?

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"

        //enable AutoLayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        view.backgroundColor = UIColor(hexString: "#D6E4E5")

        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(handleCancel))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleSave))
        navigationItem.leftBarButtonItem?.tintColor = .white

        setupNavigationStyle()
    }

    private func setupUI() {

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(hexString: "#D6E4E5")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)

        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)


        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }

    //MARK: - Objc functions
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc func handleSave() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
            
        } catch let saveErr {
            fatalError("Save Failed: \(saveErr)")
        }
        
        
    }
}
