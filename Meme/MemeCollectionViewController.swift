//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by chase on 28/04/2017.
//  Copyright © 2017 s0w4. All rights reserved.
//

import UIKit
class MemeCollectionViewController: UICollectionViewController{
    
    
    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] { return (UIApplication.shared.delegate as! AppDelegate).memes }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeCollectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memeCollectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        let meme = memes [indexPath.row]
        cell.collectionViewCellImage.image = meme.originalImage
        textFieldSet(text: meme.topText, textfield: &cell.cellTopText)
        textFieldSet(text: meme.bottomText, textfield: &cell.cellBottomText)
        return cell
    }
    
    override func collectionView(_ sentMemesCollectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailViewController, animated: true)
    }
}
