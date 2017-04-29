//
//  MemeTableViewController.swift
//  Meme
//
//  Created by chase on 28/04/2017.
//  Copyright © 2017 s0w4. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController{
    
    @IBOutlet var memesTableView: UITableView!
    
    var memes: [Meme] { return (UIApplication.shared.delegate as! AppDelegate).memes }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        memesTableView?.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        let meme = self.memes[indexPath.row]
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ sentMemesTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let detailViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailViewController, animated: true)
    }
}
