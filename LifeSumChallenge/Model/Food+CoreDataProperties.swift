//
//  Food+CoreDataProperties.swift
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

extension Food {

    @NSManaged var downloaded: NSNumber?
    @NSManaged var pcsingram: NSNumber?
    @NSManaged var language: String?
    @NSManaged var sourceId: NSNumber?
    @NSManaged var showMeasurement: NSNumber?
    @NSManaged var cholesterol: NSNumber?
    @NSManaged var gramsPerServing: NSNumber?
    @NSManaged var categoryId: NSNumber?
    @NSManaged var sugar: NSNumber?
    @NSManaged var fiber: NSNumber?
    @NSManaged var mlingram: NSNumber?
    @NSManaged var pcstext: String?
    @NSManaged var lastUpdated: NSNumber?
    @NSManaged var addedByUser: NSNumber?
    @NSManaged var fat: NSNumber?
    @NSManaged var sodium: NSNumber?
    @NSManaged var removed: NSNumber?
    @NSManaged var oCategoryId: NSNumber?
    @NSManaged var hidden: NSNumber?
    @NSManaged var custom: NSNumber?
    @NSManaged var calories: NSNumber?
    @NSManaged var oid: String?
    @NSManaged var servingCategory: NSNumber?
    @NSManaged var saturatedFat: NSNumber?
    @NSManaged var potassium: NSNumber?
    @NSManaged var brand: String?
    @NSManaged var carbohydrates: NSNumber?
    @NSManaged var typeOfMeasurement: NSNumber?
    @NSManaged var title: String?
    @NSManaged var protein: NSNumber?
    @NSManaged var defaultSize: NSNumber?
    @NSManaged var showOnlySameType: NSNumber?
    @NSManaged var unsaturatedFat: NSNumber?
    @NSManaged var category: Category?

}
