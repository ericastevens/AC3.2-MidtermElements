//
//  ElementTableViewCell.swift
//  AC3.2-MidtermElements
//
//  Created by Erica Y Stevens on 12/8/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var symbolAtomicWeightLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.elementImageView.layer.cornerRadius = self.elementImageView.frame.size.width / 2
        self.elementImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        elementImageView.image = nil
    }

}
