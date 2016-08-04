//
//  CoreDataImporter.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 3/8/16.
//
//

import Foundation
import CoreData

class CoreDataImporter {
    //MARK: - Properties
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    class func importJSONFiles() {
        let loader = JSONLoader()
        let categories = loader.loadCategories()
        let exercises = loader.loadExercises()
        let food = loader.loadFood()
        
        CoreDataManager.sharedManager.saveBackgroundContext {
            saveCategories(categories, context: $0)
            saveExercises(exercises, context: $0)
            saveFood(food, context: $0)
        }
    }
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    //MARK: - Public
    
    //MARK: - Private
    
    private class func saveCategories(json: [[String: AnyObject]]?, context: NSManagedObjectContext) {
        guard let json = json else { return }
        
        let categoryDescription = NSEntityDescription.entityForName("Category", inManagedObjectContext: context)
        let nameDescription = NSEntityDescription.entityForName("LocalizedName", inManagedObjectContext: context)
        
        if let categoryDescription = categoryDescription, nameDescription = nameDescription {
            for dict in json {
                let category = Category(entity: categoryDescription, insertIntoManagedObjectContext: context)
                category.populate(dictionary: dict)
                category.name = localizedName(entity: nameDescription, context: context, dictionary: dict)
            }
        }
    }
    
    private class func saveExercises(json: [[String: AnyObject]]?, context: NSManagedObjectContext) {
        guard let json = json else { return }
        let exerciseDescription = NSEntityDescription.entityForName("Exercise", inManagedObjectContext: context)
        let nameDescription = NSEntityDescription.entityForName("LocalizedName", inManagedObjectContext: context)
        
        if let exerciseDescription = exerciseDescription, nameDescription = nameDescription {
            for dict in json {
                let category = Exercise(entity: exerciseDescription, insertIntoManagedObjectContext: context)
                category.populate(dictionary: dict)
                category.name = localizedName(entity: nameDescription, context: context, dictionary: dict)
            }
        }
    }
    
    private class func saveFood(json: [[String: AnyObject]]?, context: NSManagedObjectContext) {
        guard let json = json else { return }
        let foodDescription = NSEntityDescription.entityForName("Food", inManagedObjectContext: context)
        
        if let foodDescription = foodDescription {
            for dict in json {
                let food = Food(entity: foodDescription, insertIntoManagedObjectContext: context)
                food.populate(dictionary: dict)
            }
        }
    }
    
    private class func localizedName(entity entity: NSEntityDescription, context: NSManagedObjectContext, dictionary dict: [String: AnyObject]) -> LocalizedName {
        let localizedName = LocalizedName(entity: entity, insertIntoManagedObjectContext: context)
        localizedName.populate(dictionary: dict)
        return localizedName
    }
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}