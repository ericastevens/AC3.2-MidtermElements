//
//  DetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Erica Y Stevens on 12/8/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var element: Element?
    let postEndpoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    @IBOutlet weak var saveFaveButton: UIButton!
    
    @IBAction func addToFavePressed(_ sender: UIButton) {
        print("BUTTON PRESSED")
        if let elem = element {
            let myFavoriteElement: [String:Any] = [
                "my_name" : "Erica Stevens",
                "favorite_element" : "\(elem.symbol)"
            ]
    
            APIRequestManager.manager.postRequest(endPoint: postEndpoint, data: myFavoriteElement)
        }
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveFaveButton.layer.cornerRadius = 5
        
        if let elem = element {
            
            self.title = elem.name
            
            idLabel.text = elem.id.description
            
            nameLabel.text = "Symbol: \(elem.symbol)"
            
            if let weight = elem.weight,
                let meltingPoint = elem.meltingC,
                let boilingPoint = elem.boilingC {
                additionalInfoLabel.text = "Atomic Weight: \(weight)\n" +
                    "Melting Point: \(meltingPoint)\n" + "Boiling Point: \(boilingPoint)"
            }
            
            let fullImageURLString = "https://s3.amazonaws.com/ac3.2-elements/\(elem.symbol).png"
            
            APIRequestManager.manager.getData(endPoint: fullImageURLString)  { (data: Data?) in
                if let validData = data,
                    let image = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        self.elementImageView.image = image
                        self.elementImageView.setNeedsLayout()
                    }
                }
            }
        } else {
            print("Element was nil")
        }
    }
    
}
