//
//  ViewController.swift
//  ConTilde
//
//  Created by user189095 on 4/16/21.
//

import UIKit

class ViewController: UIViewController {

   //let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cambiarLetra), userInfo: nil, repeats: true)
    
    @IBOutlet weak var tfName: UITextField!
        
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = defaults.string(forKey: "name")
        preferredContentSize = CGSize(width: 375, height: 467)
        
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(tfName.text, forKey: "name")
       
    }
   
    
}

