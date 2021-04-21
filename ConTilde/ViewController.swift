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
    @IBOutlet weak var btIniciarJuego: UIButton!
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btIniciarJuego.layer.cornerRadius = 10.0
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func randomVowel() -> String{
        //áéíóú ÁÉÍÓÚ
      let numeroVocal = [0:"á", 1:"é", 2:"í", 3:"ó", 4:"ú", 5:"Á", 6:"É", 7:"Í", 8:"Ó", 9:"Ú"]
      let randomInt = Int.random(in: 0...9)
      return numeroVocal[randomInt]!
   }
    
    var contador = 0
        
    @objc func fireTimer() {
        letraAnimada.text = randomVowel()
        if contador == 0 {
            
            UIView.animate(withDuration: 0.5){
                self.letraAnimada.textColor = self.randomColor()
                self.letraAnimada.font = UIFont(name: "Noteworthy", size: 180)
            }
            contador+=1
            
        }else if contador == 1 {
            
            
            
            UIView.animate(withDuration: 0.5){
                self.letraAnimada.textColor = self.randomColor()
                self.letraAnimada.font = UIFont(name: "Kefa", size: 180)
            }
            contador+=1
        }else {
            
            UIView.animate(withDuration: 0.5){
                self.letraAnimada.textColor = self.randomColor()
                self.letraAnimada.font = UIFont(name: "Papyrus", size: 180)
            }
            contador = 0
        }
    }
}

