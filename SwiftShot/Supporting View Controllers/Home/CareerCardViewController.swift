//
//  CareerCardViewController.swift
//  SwiftShot
//
//  Created by Paulo Santos on 25/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class CareerCardViewController: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var container: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gradient below text
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.insertSublayer(gradient, at: 0)

        //TODO: Set real data here
    }
    

}
