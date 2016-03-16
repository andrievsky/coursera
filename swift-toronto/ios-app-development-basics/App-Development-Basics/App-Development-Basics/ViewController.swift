//
//  ViewController.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/5/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageStateDelegate, ProcessedImageViewDelegate {

    @IBOutlet var sourceImageView: UIImageView!
    @IBOutlet var processedImageView: ProcessedImageView!
    @IBOutlet var bottomView: UIStackView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var filtersView: UIView!
    @IBOutlet var overlayLabel: UILabel!
    
    var state:ImageState = ImageState()
    var imageProcessor = ImageProcessor(image: UIImage(named: "nong-khai")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        sourceImageView.image = UIImage(named: "nong-khai")
       
        // Setup filters menu
        filtersView.translatesAutoresizingMaskIntoConstraints = false
        filtersView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        processedImageView.delegate = self
        state.delegate = self
        state.update()

    }
    
    func applyFilter(filter:Filter){
        imageProcessor.addFilter(preset: filter)
        processedImageView.image = imageProcessor.toUIImage()
        state.change(.Filter)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func changedState(state: ImageStateProperty, previousState: ImageStateProperty) {
        switch state {
        case .Init:
            shareButton?.enabled = false
            compareButton?.enabled = false
            processedImageView?.hidden = true
            overlayLabel.hidden = true
        case .Filter:
            shareButton?.enabled = true
            compareButton?.enabled = true
            processedImageView?.hidden = false
            if previousState == .Compare {
                processedImageView.show()
            }
        case .Compare:
            processedImageView.hide()
        default: return
        }
    }
    
    func processedImageViewHide(view: ProcessedImageView) {
        overlayLabel.hidden = false
    }
    
    func processedImageViewShow(view: ProcessedImageView) {
        overlayLabel.hidden = true
    }
    
    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected){
            sender.selected = false
            hideFiltersMenu()
        } else {
            sender.selected = true
            showFiltersMenu()
        }
    }
    
    func showFiltersMenu(){
        view.addSubview(filtersView)
        
        let leftConstraint = filtersView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = filtersView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let bottomConstraint = filtersView.bottomAnchor.constraintEqualToAnchor(bottomView.topAnchor)
        let heightConstraint = filtersView.heightAnchor.constraintEqualToConstant(128)
        NSLayoutConstraint.activateConstraints([leftConstraint, rightConstraint, bottomConstraint, heightConstraint])
        view.layoutIfNeeded()
        filtersView.alpha = 0.0
        UIView.animateWithDuration(0.3, animations: {
            self.filtersView.alpha = 1.0
        })
    }
    
    func hideFiltersMenu(){
        UIView.animateWithDuration(0.3, animations: {
            self.filtersView.alpha = 0.0
            }, completion: {
                (finished:Bool) in
                if(finished) {
                    self.filtersView.removeFromSuperview()
                }
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return ImageProcessor.FILTERS.count
    }
    
    let filtersList = [
        Filter.RedContrast,
        Filter.GaussianBlur
    
    ]
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cellView:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterViewCell", forIndexPath: indexPath)
        
        var image = UIImage(named: "nong-khai")
        let size = CGSize(width: 80, height: 80)
        image = ImageUtil.resize(&image!, sizeChange: size)
        let imageProcessor = ImageProcessor(image: image!)
        let filter = filtersList[indexPath.row]
        imageProcessor.addFilter(preset: filter)
        (cellView as! FilterViewCell).imageView.image = imageProcessor.toUIImage()
        (cellView as! FilterViewCell).title.text = Filter.getTitle(filter)
        
        return cellView
        
    }
    
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
        processedImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        state.change(.Filter)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onCompare(sender: UIButton) {
        if(sender.selected){
            sender.selected = false
            state.change(.Filter)
        } else {
            sender.selected = true
            state.change(.Compare)
        }
    }
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: ["Some text here!", sourceImageView.image!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        activityController.popoverPresentationController?.sourceRect = sender.bounds
        presentViewController(activityController, animated: true, completion: nil)
    }

}

