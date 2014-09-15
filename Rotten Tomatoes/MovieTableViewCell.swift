 //
//  MovieTableViewCell.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 11/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {


    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        let yellow = UIColor(red: 235/255, green: 185/255, blue: 0.0, alpha: 1.0)
        if highlighted {
            synopsisLabel.textColor = yellow
            titleLabel.textColor = yellow
        } else {
            synopsisLabel.textColor = UIColor.whiteColor()
            titleLabel.textColor = UIColor.whiteColor()
        }
    }

}
