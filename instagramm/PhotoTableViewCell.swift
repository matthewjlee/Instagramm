//
//  PhotoTableViewCell.swift
//  instagramm
//
//  Created by Matthew Lee on 3/13/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit
import Parse

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
