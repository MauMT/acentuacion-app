//
//  ViewControllerReglas.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit

class ViewControllerReglas: UIViewController {
    @IBOutlet weak var reglaButton: UIButton!
    @IBOutlet weak var diptongoHiato: UIButton!
    @IBOutlet weak var casosEspeciales: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reglaButton.layer.cornerRadius = 10.0
        diptongoHiato.layer.cornerRadius = 10.0
        casosEspeciales.layer.cornerRadius = 10.0
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "general" {
            let viewGeneral = segue.destination as! ViewControllerMuestraReglas
            
            viewGeneral.titulo = "Regla General"
            viewGeneral.textoLargo = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32."
        }
        else if segue.identifier == "Diptongo y Hiato" {
            let viewGeneral = segue.destination as! ViewControllerMuestraReglas
            
            viewGeneral.titulo = "diptongo"
            viewGeneral.textoLargo = "Vocales fuertes (F) AEO aeo Vocales débiles (D) UI Diptongo:  vocales juntas, que se pronuncian en la misma sílaba. Los diptongos pueden formarse con FD DF DD FF nunca hace diptongo Las vocales D con tilde se comportan como F Hiato.  Vocales subsecuentes que se pronuncian en sílabas distintas."
        }else{
            let viewGeneral = segue.destination as! ViewControllerMuestraReglas
            
            viewGeneral.titulo = "Casos Especiales"
            viewGeneral.textoLargo = "casos casos casoscasos casoscasos casoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasoscasos"
        }
    }
    
}
