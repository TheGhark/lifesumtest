//
//  Category+CoreDataProperties.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 4/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var category: String?
    @NSManaged var headCategoryId: NSNumber?
    @NSManaged var lastUpdated: NSNumber?
    @NSManaged var oid: NSNumber?
    @NSManaged var photoVersion: NSNumber?
    @NSManaged var servingCategory: NSNumber?
    @NSManaged var name: LocalizedName?

}
