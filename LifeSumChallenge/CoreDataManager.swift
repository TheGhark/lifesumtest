//
//  CoreDataManager.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import Foundation
import CoreData

class CoreDataManager {
    //MARK: - Properties
    
    static let sharedManager = CoreDataManager()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    var managedObjectModel: NSManagedObjectModel!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    private(set) var mainContext: NSManagedObjectContext!
    private(set) var backgroundContext: NSManagedObjectContext!
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func initialize() {
        let modelURL = NSBundle.mainBundle().URLForResource("LifeSumChallenge", withExtension: "momd")!
        managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        
        initializeCoordinator()
        initializeContexts()
    }
    
    func saveAll() {
        save(context: backgroundContext)
        save(context: mainContext)
    }
    
    func saveMainContext(block block: ((NSManagedObjectContext) -> Void)?) {
        mainContext.performBlock { [unowned self] in
            block?(self.mainContext)
            self.save(context: self.mainContext)
        }
    }
    
    func saveBackgroundContext(block block: ((NSManagedObjectContext) -> Void)?) {
        backgroundContext.performBlock { [unowned self] in
            block?(self.backgroundContext)
            self.save(context: self.backgroundContext)
        }
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    private func initializeCoordinator() {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        let failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "com.lifesumchallenge", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        persistentStoreCoordinator = coordinator
    }
    
    private func initializeContexts() {
        let mainContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = persistentStoreCoordinator
        self.mainContext = mainContext
        
        let backgroundContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        backgroundContext.parentContext = mainContext
        self.backgroundContext = backgroundContext
    }
    
    private func save(context context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo), in context \(context)")
            }
        }
    }
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}