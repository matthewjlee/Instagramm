//
//  PhotosViewController.swift
//  instagramm
//
//  Created by Matthew Lee on 3/13/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [PFObject]?
    var user: PFUser?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        query()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        
        self.user = PFUser.current()
        //query()
    }
    
    func query() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("photo")
        query.findObjectsInBackground {
            (results: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("ERROR: data retrieval failed")
            } else {
                if let results = results {
                    print("Successfully retrieved \(results.count) posts")
                    self.posts = results
                    self.tableView.reloadData()
                } else {
                    print("No results returned")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        
        if let post = posts?[indexPath.row] {
            cell.captionLabel.text = post["caption"] as! String?
            let photo = post["photo"] as! PFObject
            if let imageData = photo["image"] as? PFFile {
                imageData.getDataInBackground(block: { (data: Data?, error: Error?) in
                    if let data = data {
                        cell.photo.image = UIImage.init(data: data)
                    }
                })
            }
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
