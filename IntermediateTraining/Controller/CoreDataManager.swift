//
//  CoreDataManager.swift
//  IntermediateTraining
//
//  Created by huygur on 1.12.2022.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IntermediateTrainingCoreDataModels")
        container.loadPersistentStores { storeDesription, err in
            if let err = err {
                fatalError("Connection Failed: \(err)")
            }
        }
        return container
        
    }()

}
