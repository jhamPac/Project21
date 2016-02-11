//
//  ViewController.swift
//  P2P
//
//  Created by jhampac on 2/10/16.
//  Copyright © 2016 jhampac. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate
{
    var images = [UIImage]()
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAssistant: MCAdvertiserAssistant!
    
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
        let addSessionButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "showConnectionPrompt")
        navigationItem.rightBarButtonItem = cameraButton
        navigationItem.leftBarButtonItem = addSessionButton
        
        //MC set up
        peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .Required)
        mcSession.delegate = self
    }
    
    //MARK: - VC Methods
    
    func importPicture()
    {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func showConnectionPrompt()
    {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .Default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .Default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func startHosting(action: UIAlertAction)
    {
        mcAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAssistant.start()
    }
    
    func joinSession(action: UIAlertAction)
    {
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        presentViewController(mcBrowser, animated: true, completion: nil)
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

