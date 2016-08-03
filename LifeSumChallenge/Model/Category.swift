//
//  Category.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import Foundation
import CoreData


class Category: NSManagedObject {
    //MARK: - Properties
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func populate(dictionary dict: [String: AnyObject]) {
        category = dict["category"] as? String
        headCategoryId = dict["headcategoryid"] as? NSNumber
        servingCategory = dict["servingcategory"] as? NSNumber
        oid = dict["oid"] as? NSNumber
        photoVersion = dict["photo_version"] as? NSNumber
        lastUpdated = dict["lastUpdated"] as? NSNumber
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}
