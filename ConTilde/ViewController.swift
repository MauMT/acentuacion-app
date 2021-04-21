//
//  ViewController.swift
//  ConTilde
//
//  Created by user189095 on 4/16/21.
//

import UIKit

class ViewController: UIViewController {

   //let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cambiarLetra), userInfo: nil, repeats: true)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
   
}

