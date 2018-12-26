//
//  MultiplayerCardViewController.swift
//  SwiftShot
//
//  Created by Paulo Santos on 25/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MultiplayerCardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    fileprivate let reuseIdentifier = "levelCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    //MARK:UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameLevel.allLevels.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let level = GameLevel.allLevels[indexPath.row]
        
        
        let cell : MultiplayerCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MultiplayerCardCollectionViewCell
        
        cell.titleLabel.text = level.name
        cell.imageView.image = UIImage(named: "level_farm")
        
        return cell
        
    }
    

}
