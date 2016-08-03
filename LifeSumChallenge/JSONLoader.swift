//
//  JSONLoader.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 3/8/16.
//
//

import Foundation

class JSONLoader {
    //MARK: - Properties
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func loadCategories() -> [[String: AnyObject]]? {
        return load(filename: "categoriesStatic")
    }
    
    func loadExercises() -> [[String: AnyObject]]? {
        return load(filename: "exercisesStatic")
    }
    
    func loadFood() -> [[String: AnyObject]]? {
        return load(filename: "foodStatic")
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    private func load(filename filename: String) -> [[String: AnyObject]]? {
        guard let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") else { return nil }
        guard let data = NSData(contentsOfFile: path) else { return nil }
        
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]]
        } catch {
            print("Cannot parse \(filename) file")
        }
        
        return nil
    }
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}