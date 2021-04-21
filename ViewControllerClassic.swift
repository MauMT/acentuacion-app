//
//  ViewControllerClassic.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit

class ViewControllerClassic: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    }
    

    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        
        
    }

}
