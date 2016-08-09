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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var factory: FRCFactory!
    private var searching = false
    private var filtered = [AnyObject]()
    
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
        
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }
    
    //MARK: - Actions
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        view.endEditing(true)
        
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
    
    private func hideLoadingView() {
        if !loadingView.hidden {
            UIView.animateWithDuration(0.25, animations: {
                self.loadingView.alpha = 0
                }, completion: { _ in
                    self.loadingView.hidden = true
                    self.activityIndicator.stopAnimating()
            })
        }
    }
    
    private func clearSearch() {
        searching = false
        filtered.removeAll()
        tableView.reloadData()
    }
    
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
        guard !searching else {
            return 1
        }
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !searching else {
            return filtered.count
        }
        
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
            let exercise = searching ? filtered[indexPath.row] as? Exercise : controller.objectAtIndexPath(indexPath) as? Exercise
            text = exercise?.title
        case 2:
            let food = searching ? filtered[indexPath.row] as? Food : controller.objectAtIndexPath(indexPath) as? Food
            text = food?.title
        default:
            let category = searching ? filtered[indexPath.row] as? Category : controller.objectAtIndexPath(indexPath) as? Category
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
        
        hideLoadingView()
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            clearSearch()
            return
        }
        
        searching = true
        let objects = controller.fetchedObjects
        
        if let objects = objects as? [Category] {
            filtered = objects.filter { $0.contains(searchText) }
        } else if let objects = objects as? [Exercise] {
            filtered = objects.filter { $0.contains(searchText) }
        } else if let objects = objects as? [Food] {
            filtered = objects.filter { $0.contains(searchText) }
        }
        
        tableView.reloadData()
    }
}

