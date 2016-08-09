//
//  ViewController.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import UIKit
import CoreData

private let CellIdentifier = "CellIdentifier"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    //MARK: - Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = sender as? NSIndexPath, detailsVC = segue.destinationViewController as? DetailsViewController {
            switch segmentedControl.selectedSegmentIndex {
            case 1:
                let exercise = controller.objectAtIndexPath(indexPath) as? Exercise
                detailsVC.setup(title: exercise?.title, names: exercise?.name?.description)
                
            default:
                let category = controller.objectAtIndexPath(indexPath) as? Category
                detailsVC.setup(title: category?.category, names: category?.name?.description)
            }
        }
    }
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
        var text: String?
        
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            let exercise = controller.objectAtIndexPath(indexPath) as? Exercise
            text = exercise?.title
        case 2:
            let food = controller.objectAtIndexPath(indexPath) as? Food
            text = food?.title
        default:
            let category = controller.objectAtIndexPath(indexPath) as? Category
            text = category?.category
        }
        
        cell.textLabel?.text = text
        cell.selectionStyle = .None
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch segmentedControl.selectedSegmentIndex {
        case 2:
            return nil
        default:
            return indexPath
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var text: String?
        
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            let exercise = controller.objectAtIndexPath(indexPath) as? Exercise
            text = exercise?.title
            
        default:
            let category = controller.objectAtIndexPath(indexPath) as? Category
            text = category?.category
        }
        
        if text?.characters.count > 1 {
            performSegueWithIdentifier("showDetails", sender: indexPath)
        }
    }
    
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
        
        if !loadingView.hidden {
            UIView.animateWithDuration(0.25, animations: { 
                self.loadingView.alpha = 0
                }, completion: { _ in
                    self.loadingView.hidden = true
                    self.activityIndicator.stopAnimating()
            })
        }
    }
}

