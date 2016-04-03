//
//  ViewController.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/5/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bottomView: UIStackView!
    @IBOutlet var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //imageView.image = UIImage(named: "nong-khai")
        ImageModel.getInstance().update(withImage: UIImage(named: "nong-khai")!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = ImageModel.getInstance().getImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: New Photo
    
    @IBAction func onNewPhoto(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        actionSheet.popoverPresentationController?.sourceView = sender
        actionSheet.popoverPresentationController?.sourceRect = sender.bounds
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: showCamera))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: showAlbum))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera(action: UIAlertAction?){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        present(picker)
    }
    
    func showAlbum(action: UIAlertAction?){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        present(picker)
    }
    
    func present(viewController: UIViewController){
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        ImageModel.getInstance().update(withImage: imageView.image!)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Share Handling
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: ["Some text here!", imageView.image!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        activityController.popoverPresentationController?.sourceRect = sender.bounds
        presentViewController(activityController, animated: true, completion: nil)
    }
}

