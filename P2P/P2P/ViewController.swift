//
//  ViewController.swift
//  P2P
//
//  Created by jhampac on 2/10/16.
//  Copyright © 2016 jhampac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var images = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Selfie Share"
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "importPicture")
        navigationItem.rightBarButtonItem = cameraButton
    }
    
    func importPicture()
    {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    //MARK: - CollectionView Protocols
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageView", forIndexPath: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView
        {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    //MARK: - UIImagePicker Protocols
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            newImage = possibleImage
        }
        else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            newImage = possibleImage
        }
        else
        {
            return
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        images.insert(newImage, atIndex: 0)
        collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

