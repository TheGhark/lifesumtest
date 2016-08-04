//
//  LocalizedName+CoreDataProperties.swift
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

extension LocalizedName {

    @NSManaged var nameDA: String?
    @NSManaged var nameDE: String?
    @NSManaged var nameES: String?
    @NSManaged var nameFI: String?
    @NSManaged var nameFR: String?
    @NSManaged var nameIT: String?
    @NSManaged var nameNL: String?
    @NSManaged var nameNO: String?
    @NSManaged var namePL: String?
    @NSManaged var namePT: String?
    @NSManaged var nameRU: String?
    @NSManaged var nameSV: String?
    @NSManaged var category: Category?
    @NSManaged var exercise: Exercise?

}
