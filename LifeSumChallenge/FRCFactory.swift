//
//  FRCFactory.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 9/8/16.
//
//

import Foundation
import CoreData

class FRCFactory {
    //MARK: - Properties
    
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    private lazy var categoriesFRC: NSFetchedResultsController = {
        let sort = NSSortDescriptor(key: "category", ascending: true)
        return FRCFactory.fetchedResultsController(entityName: "Category", sortDescriptors: [sort])
    }()
    
    private lazy var exercisesFRC: NSFetchedResultsController = {
        let sort = NSSortDescriptor(key: "title", ascending: true)
        return FRCFactory.fetchedResultsController(entityName: "Exercise", sortDescriptors: [sort])
    }()
    
    private lazy var foodFRC: NSFetchedResultsController = {
        let sort = NSSortDescriptor(key: "title", ascending: true)
        return FRCFactory.fetchedResultsController(entityName: "Food", sortDescriptors: [sort])
    }()
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    private class func fetchedResultsController(entityName entityName: String, sortDescriptors: [NSSortDescriptor]) -> NSFetchedResultsController {
        let request = NSFetchRequest(entityName: entityName)
        request.fetchBatchSize = 20
        request.sortDescriptors = sortDescriptors
        let context = CoreDataManager.sharedManager.mainContext
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    //MARK: - Initialization
    
    init(delegate: NSFetchedResultsControllerDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func categoriesFetchedResultsController() -> NSFetchedResultsController {
        categoriesFRC.delegate = delegate
        return categoriesFRC
    }
    
    func exercisesFetchedResultsController() -> NSFetchedResultsController {
        exercisesFRC.delegate = delegate
        return exercisesFRC
    }
    
    func foodFetchedResultsController() -> NSFetchedResultsController {
        foodFRC.delegate = delegate
        return foodFRC
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}