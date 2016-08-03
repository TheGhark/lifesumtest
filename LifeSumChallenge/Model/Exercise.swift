//
//  Exercise.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import Foundation
import CoreData


class Exercise: NSManagedObject {
    //MARK: - Properties
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func populate(dictionary dict: [String: AnyObject]) {
        hidden = dict["hidden"] as? NSNumber
        removed = dict["removed"] as? NSNumber
        downloaded = dict["downloaded"] as? NSNumber
        photoVersion = dict["photo_version"] as? NSNumber
        custom = dict["custom"] as? NSNumber
        oid = dict["oid"] as? NSNumber
        lastUpdated = dict["lastupdated"] as? NSNumber
        addedByUser = dict["addebyuser"] as? NSNumber
        title = dict["title"] as? String
        calories = dict["calories"] as? NSNumber
        name = LocalizedName().populate(dictionary: dict)
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}
