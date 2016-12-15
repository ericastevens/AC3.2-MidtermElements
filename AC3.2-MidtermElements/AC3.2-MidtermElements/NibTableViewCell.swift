//
//  NibTableViewCell.swift
//  AC3.2-MidtermElements
//
//  Created by Erica Y Stevens on 12/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class NibTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var elementimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
