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
    
    var post: PFObject!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData() {
        if let post = post {
            self.label.text = post["caption"] as? String
            let imageFile = post["media"] as! PFFile
            
            imageFile.getDataInBackground { (data: Data?, error: Error?) in
                if error == nil {
                    if let data = data {
                        self.photo.image = UIImage(data: data)
                    }
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        /**
        self.label.text = post?["caption"] as? String
        let imageFile = post?["media"] as! PFFile
        
        imageFile.getDataInBackground { (data: Data?, error: Error?) in
            if error == nil {
                if let data = data {
                    self.photo.image = UIImage(data: data)
                }
            } else {
                print(error?.localizedDescription)
            }
        }
 */
    }

}
