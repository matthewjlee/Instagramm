//
//  CaptureViewController.swift
//  instagramm
//
//  Created by Matthew Lee on 3/13/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var captionBar: UITextField!
    @IBOutlet weak var userPromptLabel: UILabel!
    
    var pickedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPhotoTap(_ sender: Any) {
        print("reached photo tap")
        let checkCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //if camera is not available, restrict selection to photo library
        let sourceType = checkCamera ? UIImagePickerControllerSourceType.camera : UIImagePickerControllerSourceType.photoLibrary
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = sourceType
        
        self.present(vc, animated: true, completion: nil)
        print("hello")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //taking the picked image
        self.pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //setting the preview screen to the picked image
        self.previewImage.image = self.pickedImage
        self.previewImage.alpha = 1
        self.previewImage.backgroundColor = UIColor.white
        self.userPromptLabel.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onSubmit(_ sender: Any) {
        let resizedImage = self.resize(image: self.pickedImage, newSize: CGSize(width: 750, height: 750))
        let imageData = UIImageJPEGRepresentation(self.pickedImage, 0)
        let imageFile = PFFile(name: "newImage.jpg", data: imageData!)
        
        let photo = PFObject(className: "Photo")
        photo["image"] = imageFile
        
        let post = PFObject(className: "Post")
        post["photo"] = photo
        post["caption"] = self.captionBar.text
        post.saveInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Post saved!")
                //self.alertMessage
                self.resetViews()
                self.tabBarController!.selectedIndex = 0
            }
        }
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func resetViews() {
        self.previewImage.image = nil
        self.captionBar.text = ""
        self.previewImage.backgroundColor = UIColor.gray
    }
    
    func presentImage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let checkAction = UIAlertAction(title: "Cool", style: .default, handler: nil)
        
        ac.addAction(checkAction)
        self.present(ac, animated: true, completion: nil)
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
