//
//  ViewController.swift
//  P2P
//
//  Created by jhampac on 2/10/16.
//  Copyright © 2016 jhampac. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Selfie Share"
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "importPicture")
        navigationItem.rightBarButtonItem = cameraButton
    }
    
    func importPicture()
    {
        
    }
}

