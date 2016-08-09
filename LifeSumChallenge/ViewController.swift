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
    
    private var factory: FRCFactory!
    
    //MARK: - Computed Properties
    
    private var controller: NSFetchedResultsController {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return factory.categoriesFetchedResultsController()
        case 1:
            return factory.exercisesFetchedResultsController()
        default:
            return factory.foodFetchedResultsController()
        }
    }
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory = FRCFactory(delegate: self)
        
        do {
            try controller.performFetch()
        } catch {
            print("An error occured when fetching: \(error as NSError)")
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

