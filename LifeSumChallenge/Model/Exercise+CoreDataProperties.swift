//
//  Exercise+CoreDataProperties.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercise {

    @NSManaged var hidden: NSNumber?
    @NSManaged var removed: NSNumber?
    @NSManaged var downloaded: NSNumber?
    @NSManaged var photoVersion: NSNumber?
    @NSManaged var custom: NSNumber?
    @NSManaged var oid: NSNumber?
    @NSManaged var lastUpdated: NSNumber?
    @NSManaged var addedByUser: NSNumber?
    @NSManaged var title: String?
    @NSManaged var calories: NSNumber?
    @NSManaged var name: LocalizedName?

}
