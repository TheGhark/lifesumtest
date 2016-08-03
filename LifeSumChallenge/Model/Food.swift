//
//  Food.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import Foundation
import CoreData


class Food: NSManagedObject {
    //MARK: - Properties
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func populate(dictionary dict: [String: AnyObject]) {
        downloaded = dict["downloaded"] as? NSNumber
        pcsingram = dict["pcsingram"] as? NSNumber
        language = dict["language"] as? String
        sourceId = dict["source_id"] as? NSNumber
        showMeasurement = dict["showmeasurement"] as? NSNumber
        cholesterol = dict["cholesterol"] as? NSNumber
        gramsPerServing = dict["gramsperserving"] as? NSNumber
        categoryId = dict["categoryid"] as? NSNumber
        sugar = dict["sugar"] as? NSNumber
        fiber = dict["fiber"] as? NSNumber
        mlingram = dict["mlingram"] as? NSNumber
        pcstext = dict["pcstext"] as? String
        lastUpdated = dict["lastupdated"] as? NSNumber
        addedByUser = dict["addedbyuser"] as? NSNumber
        fat = dict["fat"] as? NSNumber
        sodium = dict["sodium"] as? NSNumber
        removed = dict["removed"] as? NSNumber
        oCategoryId = dict["ocategoryid"] as? NSNumber
        hidden = dict["hidden"] as? NSNumber
        custom = dict["custom"] as? NSNumber
        calories = dict["calories"] as? NSNumber
        oid = dict["oid"] as? String
        servingCategory = dict["servingcategory"] as? NSNumber
        saturatedFat = dict["saturatedfat"] as? NSNumber
        potassium = dict["potassium"] as? NSNumber
        brand = dict["brand"] as? String
        carbohydrates = dict["carbohydrates"] as? NSNumber
        typeOfMeasurement = dict["typeofmeasurement"] as? NSNumber
        title = dict["title"] as? String
        protein = dict["protein"] as? NSNumber
        defaultSize = dict["defaultsize"] as? NSNumber
        showOnlySameType = dict["showonlysametype"] as? NSNumber
        unsaturatedFat = dict["unsaturatedfat"] as? NSNumber
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}
