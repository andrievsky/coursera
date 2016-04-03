//
//  StorageViewController.swift
//  App Design and Development for iOS
//
//  Created by Nick Andrievsky on 4/3/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class StorageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var loadButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = ImageModel.getInstance().getImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoad(sender: AnyObject) {
        let images = DataModel.getInstance().loadImages()
        if images.count < 1 {
            return
        }
        guard let image = images[images.count - 1] as Image? else {
            return
        }
        
        ImageModel.getInstance().update(withImage: UIImage(data: (image.sourse)!)!)
        imageView.image = ImageModel.getInstance().getImage()
        
    }
    
    @IBAction func onSave(sender: AnyObject) {
        let imageData = UIImageJPEGRepresentation(ImageModel.getInstance().getImage(), 1.0)
        DataModel.getInstance().save(imageData!, comment: "")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
