//
//  LocalizedName.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 2/8/16.
//
//

import Foundation
import CoreData


class LocalizedName: NSManagedObject {
    //MARK: - Properties
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func populate(dictionary dict: [String: AnyObject]) -> LocalizedName {
        nameDA = dict["name_da"] as? String
        nameDE = dict["name_de"] as? String
        nameFI = dict["name_fi"] as? String
        nameFR = dict["name_fr"] as? String
        nameIT = dict["name_it"] as? String
        nameNL = dict["name_nl"] as? String
        nameNO = dict["name_no"] as? String
        namePL = dict["name_pl"] as? String
        namePT = dict["name_pt"] as? String
        nameRU = dict["name_ru"] as? String
        nameSV = dict["name_sv"] as? String
        nameES = dict["name_es"] as? String
        
        return self
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}
