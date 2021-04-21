//
//  ViewControllerZenGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 20/04/21.
//
import UIKit

class ViewControllerZen: UIViewController {

    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbPalabra: UILabel!
    
    // Lista de palabras de prueba
    var listaPalabras = [Palabra(palabra: "hola", correcta: true), Palabra(palabra: "comida", correcta: true), Palabra(palabra: "raton", correcta: false), Palabra(palabra: "telefono", correcta: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaPalabras.shuffle()
        lbPalabra.text = listaPalabras[listaPalabras.count - 1].palabra

        // Do any additional setup after loading the view.
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
            } else {
                puntos = 0
            }
            lbPuntos.text = String(puntos)
            if (listaPalabras.count > 1) {
                listaPalabras.popLast()
                lbPalabra.text = listaPalabras[listaPalabras.count - 1].palabra
            }
            
        }
        
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
