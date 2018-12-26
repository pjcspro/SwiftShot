//
//  MultiplayerCardViewController.swift
//  SwiftShot
//
//  Created by Paulo Santos on 25/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit


protocol MultiplayerCardViewControllerDelegate: class {
    func multiplayerCardViewController(_ multiplayerCardViewController: MultiplayerCardViewController, didPressJoinGameButton: UILabel)
    
    func multiplayerCardViewController(_ multiplayerCardViewController: MultiplayerCardViewController, didPressHostGameForLevel: GameLevel)
}

class MultiplayerCardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate let reuseIdentifier = "levelCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var joinButton: UILabel!
    
    weak var delegate: MultiplayerCardViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapJoin(_:)))
        joinButton.addGestureRecognizer(tap)
        
    }
    
    @objc func didTapJoin(_ sender: UITapGestureRecognizer) {
        delegate?.multiplayerCardViewController(self, didPressJoinGameButton: joinButton)
    }
    
    //MARK:UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameLevel.allLevels.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let level = GameLevel.allLevels[indexPath.row]
        
        
        let cell : MultiplayerCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MultiplayerCardCollectionViewCell
        
        cell.titleLabel.text = level.name
        cell.imageView.image = UIImage(named: level.previewImage)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let level = GameLevel.allLevels[indexPath.row]
        delegate?.multiplayerCardViewController(self, didPressHostGameForLevel: level)
        
    }

}
