//
//  DetailViewController.swift
//  Meme
//
//  Created by Chase on 29/04/2017.
//  Copyright © 2017 s0w4. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var detailViewImage: UIImageView!
    var meme: Meme?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailViewImage.image = meme?.memedImage
    }
}
