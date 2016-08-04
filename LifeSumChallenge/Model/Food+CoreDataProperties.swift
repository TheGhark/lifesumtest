//
//  Food+CoreDataProperties.swift
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

extension Food {

    @NSManaged var addedByUser: NSNumber?
    @NSManaged var brand: String?
    @NSManaged var calories: NSNumber?
    @NSManaged var carbohydrates: NSNumber?
    @NSManaged var categoryId: NSNumber?
    @NSManaged var cholesterol: NSNumber?
    @NSManaged var custom: NSNumber?
    @NSManaged var defaultSize: NSNumber?
    @NSManaged var downloaded: NSNumber?
    @NSManaged var fat: NSNumber?
    @NSManaged var fiber: NSNumber?
    @NSManaged var gramsPerServing: NSNumber?
    @NSManaged var hidden: NSNumber?
    @NSManaged var language: String?
    @NSManaged var lastUpdated: NSNumber?
    @NSManaged var mlingram: NSNumber?
    @NSManaged var oCategoryId: NSNumber?
    @NSManaged var oid: String?
    @NSManaged var pcsingram: NSNumber?
    @NSManaged var pcstext: String?
    @NSManaged var potassium: NSNumber?
    @NSManaged var protein: NSNumber?
    @NSManaged var removed: NSNumber?
    @NSManaged var saturatedFat: NSNumber?
    @NSManaged var servingCategory: NSNumber?
    @NSManaged var showMeasurement: NSNumber?
    @NSManaged var showOnlySameType: NSNumber?
    @NSManaged var sodium: NSNumber?
    @NSManaged var sourceId: NSNumber?
    @NSManaged var sugar: NSNumber?
    @NSManaged var title: String?
    @NSManaged var typeOfMeasurement: NSNumber?
    @NSManaged var unsaturatedFat: NSNumber?

}
