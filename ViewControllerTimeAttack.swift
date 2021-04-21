//
//  ViewControllerTimeAttack.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit

class ViewControllerTimeAttack: UIViewController {

    
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbPalabra: UILabel!
    @IBOutlet weak var lbTiempo: UILabel!
    
    // Lista de palabras de prueba
    var listaPalabras = [Palabra(palabra: "hola", correcta: true), Palabra(palabra: "comida", correcta: true), Palabra(palabra: "raton", correcta: false), Palabra(palabra: "telefono", correcta: false)]
    
    
    var timeRemaining : Int = 10
    var timer : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
        listaPalabras.shuffle()
        lbPalabra.text = listaPalabras[listaPalabras.count - 1].palabra

        // Do any additional setup after loading the view.
    }
    
    
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            // Se te acabo el tiempo papu :V
            // timer.invalidate()
            timeRemaining = 10
            lbPuntos.text = "0"
        }
        lbTiempo.text = String(timeRemaining)
    }
    
    
    
    @IBAction func opcionSi(_ sender: UIButton) {
        actualizarPuntaje(opcion: true)
    }
    
    @IBAction func opcionNo(_ sender: UIButton) {
        actualizarPuntaje(opcion: false)
    }
    
    func actualizarPuntaje(opcion : Bool) {
        let respuesta = listaPalabras[listaPalabras.count - 1].correcta
        
        if var puntos = Int(lbPuntos.text!) {
            if (opcion == respuesta) {
                puntos = puntos + 1
                timeRemaining += 3
            } else {
                timeRemaining -= 3
                if timeRemaining < 0 {
                    // perdiste papu :V
                    puntos = 0
                    timeRemaining = 10
                }
            }
            lbTiempo.text = String(timeRemaining)
            lbPuntos.text = String(puntos)
            if (listaPalabras.count > 1) {
                listaPalabras.popLast()
                lbPalabra.text = listaPalabras[listaPalabras.count - 1].palabra
            }
            
        }
        
    }
    
}
