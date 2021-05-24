//
//  ViewControllerMuestraReglas.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit


class ViewControllerMuestraReglas: UIViewController{
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    @IBOutlet weak var contenedorTexto: UITextView!
    
    var titulo : String!
    var textoLargo : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titulo = titulo.uppercased()
        contenedorTexto.text = titulo+"\n"+textoLargo
        
    }
    

    @IBAction func quitarMiniVista(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}
