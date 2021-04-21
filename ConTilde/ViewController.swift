//
//  ViewController.swift
//  ConTilde
//
//  Created by user189095 on 4/16/21.
//

import UIKit

class ViewController: UIViewController {

   //let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cambiarLetra), userInfo: nil, repeats: true)
    
    @IBOutlet weak var letraAnimada: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var contador = 0
    /*@IBAction func cambiarLetra(){
        //áéíóú
        switch contador{
        case 0:
            letraAnimada.text! = "á"
            contador+=1
        case 1:
            letraAnimada.text! = "é"
            contador+=1
        case 2:
            letraAnimada.text! = "í"
            contador+=1
        case 3:
            letraAnimada.text! = "ó"
            contador+=1
        case 4:
            letraAnimada.text! = "ú"
            contador=0
        default:
            letraAnimada.text! = "á"
        }
        
    }*/
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

