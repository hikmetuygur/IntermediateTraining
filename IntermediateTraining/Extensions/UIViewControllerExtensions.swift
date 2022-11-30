//
//  UIViewControllerExtensions.swift
//  IntermediateTraining
//
//  Created by huygur on 30.11.2022.
//

import UIKit

extension UIViewController {
    
    func setupNavigationStyle() {
        navigationController?.navigationBar.isTranslucent = false
        
        let orange = UIColor(hexString: "#EB6440")
        
        navigationController?.navigationBar.barTintColor = orange
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}
