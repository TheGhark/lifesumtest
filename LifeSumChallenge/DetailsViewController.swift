//
//  DetailsViewController.swift
//  LifeSumChallenge
//
//  Created by Camilo Rodriguez Gaviria on 9/8/16.
//
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    //MARK: - Properties
    
    private var objectTitle: String?
    private var objectNames: String?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var relatedNames: UITextView!
    
    //MARK: - Computed Properties
    
    //MARK: - Class Methods
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = objectTitle
        relatedNames.text = objectNames
        title = "Details"
    }
    
    //MARK: - Actions
    
    //MARK: - Internal
    
    func setup(title title: String?, names: String?) {
        objectTitle = title
        objectNames = names
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Overridden
    
    //MARK: - <#Delegates#>
}