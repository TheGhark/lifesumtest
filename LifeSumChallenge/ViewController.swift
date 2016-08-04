//
//  ViewController.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import UIKit
import CoreData

private let CategoryCellIdentifier = "CategoryCellIdentifier"
private let ExerciseCellIdentifier = "ExerciseCellIdentifier"
private let FoodCellIdentifier = "FoodCellIdentifier"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    //MARK: - Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var categoriesFRC: NSFetchedResultsController = {
        let request = NSFetchRequest(entityName: "Category")
        request.fetchBatchSize = 20
        request.propertiesToFetch = ["category"]
        let sort = NSSortDescriptor(key: "category", ascending: true)
        request.sortDescriptors = [sort]
        let context = CoreDataManager.sharedManager.mainContext
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        return controller
    }()
    
    private lazy var exercisesFRC: NSFetchedResultsController = {
        let request = NSFetchRequest(entityName: "Exercise")
        request.fetchBatchSize = 20
        request.propertiesToFetch = ["title"]
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        let context = CoreDataManager.sharedManager.mainContext
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        return controller
    }()
    
    private lazy var foodFRC: NSFetchedResultsController = {
        let request = NSFetchRequest(entityName: "Food")
        request.fetchBatchSize = 20
        request.propertiesToFetch = ["title"]
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        let context = CoreDataManager.sharedManager.mainContext
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        return controller
    }()
    
    //MARK: - Computed Properties
    
    private var controller: NSFetchedResultsController {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return categoriesFRC
        case 1:
            return exercisesFRC
        default:
            return foodFRC
        }
    }
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try categoriesFRC.performFetch()
        } catch {
            print("An error occured when fetching categories: \(error as NSError)")
        }
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CategoryCellIdentifier)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ExerciseCellIdentifier)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: FoodCellIdentifier)
    }
    
    //MARK: - Actions
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        do {
            try controller.performFetch()
        } catch {
            print("An error occured when fetching objects: \(error as NSError)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - Internal
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections where !sections.isEmpty {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(ExerciseCellIdentifier, forIndexPath: indexPath)
            let exercise = controller.objectAtIndexPath(indexPath) as? Exercise
            cell.textLabel?.text = exercise?.title
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(FoodCellIdentifier, forIndexPath: indexPath)
            let food = controller.objectAtIndexPath(indexPath) as? Food
            cell.textLabel?.text = food?.title
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(CategoryCellIdentifier, forIndexPath: indexPath)
            let category = controller.objectAtIndexPath(indexPath) as? Category
            cell.textLabel?.text = category?.category
            
            return cell
        }
    }
    
    //MARK: - UITableViewDelegate
    
    //MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type) {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        case .Update:
            if let indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}

