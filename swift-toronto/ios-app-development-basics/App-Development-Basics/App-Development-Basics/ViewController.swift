//
//  ViewController.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/5/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageStateDelegate, ProcessedImageViewDelegate, UICollectionViewDelegate {

    @IBOutlet var sourceImageView: UIImageView!
    @IBOutlet var processedImageView: ProcessedImageView!
    @IBOutlet var bottomView: UIStackView!
    @IBOutlet var editView: UIView!
    @IBOutlet var additionalView: AdditionalView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var filtersView: UIView!
    @IBOutlet var overlayLabel: UILabel!
    @IBOutlet var filtersCollectionView: UICollectionView!
    
    
    var state:ImageState = ImageState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        sourceImageView.image = UIImage(named: "nong-khai")
        processedImageView.delegate = self
        state.delegate = self
        state.update()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // States Handling
    
    func changedState(state: ImageStateProperty, previousState: ImageStateProperty) {
        //print("\(state) <- \(previousState)")
        switch state {
        case .Init:
            if additionalView.isOpen(){
                additionalView.close()
            }
            processedImageView.recreate(sourceImageView.image!)
            overlayLabel.hidden = true
            filtersCollectionView.reloadData()
            compareButton.selected = false
        case .Ready:
            if additionalView.isOpen(){
                additionalView.close()
            }
        case .Edit:
            additionalView!.open(editView)
        case .Filters:
            additionalView!.open(filtersView)
        }
        
        shareButton?.enabled = processedImageView.hasFilter()
        compareButton?.enabled = processedImageView.hasFilter()
        editButton?.enabled = processedImageView.hasFilter()
        processedImageView?.hidden = state == .Init
        filterButton.selected = state == .Filters
        editButton.selected = state == .Edit
    }
    
    // New Photo Menu and Delegate
    
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
        sourceImageView.image = image
        state.change(.Init)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Filters Handling
    
    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected){
            state.change(.Ready)
        } else {
            state.change(.Filters)
        }
    }
    
    let filtersList = [
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur
    ]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return filtersList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cellView:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterViewCell", forIndexPath: indexPath)
        
        var image = sourceImageView.image
        let size = CGSize(width: 80, height: 80)
        image = ImageUtil.resize(&image!, sizeChange: size)
        let imageProcessor = ImageProcessor(image: image!)
        let filter = filtersList[indexPath.row]
        imageProcessor.addFilter(preset: filter)
        (cellView as! FilterViewCell).imageView.image = imageProcessor.toUIImage()
        (cellView as! FilterViewCell).title.text = Filter.getTitle(filter)
        
        return cellView
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        processedImageView.applyFilter(filtersList[indexPath.row])
        state.change(.Ready)
    }
    
    // Edit Handling
    
    @IBAction func onEdit(sender: UIButton) {
        if(sender.selected){
            state.change(.Ready)
        } else {
            state.change(.Edit)
        }
    }
    
    @IBAction func onEditChaged(sender: UISlider) {
        processedImageView.adjust(sender.value)
    }
    
    // Image View Delegate
    
    func processedImageViewHide(view: ProcessedImageView) {
        if processedImageView.hasFilter() {
            overlayLabel.hidden = false
        }
    }
    
    func processedImageViewShow(view: ProcessedImageView) {
        if processedImageView.hasFilter() {
            overlayLabel.hidden = true
        }
    }
    
    // Compare Handling
    
    @IBAction func onCompare(sender: UIButton) {
        if(sender.selected){
            compareButton.selected = false
            processedImageView.show()
        } else {
            compareButton.selected = true
            processedImageView.hide()
        }
    }
    
    // Share Handling
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: ["Some text here!", sourceImageView.image!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        activityController.popoverPresentationController?.sourceRect = sender.bounds
        presentViewController(activityController, animated: true, completion: nil)
    }
}

