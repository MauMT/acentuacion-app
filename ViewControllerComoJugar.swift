    //
//  ViewControllerComoJugar.swift
//  ConTilde
//
//  Created by user189095 on 5/7/21.
//

import UIKit

    class ViewControllerComoJugar: UIViewController {
        
        
        var texto:String!
    @IBOutlet weak var lbExplicacion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbExplicacion.text = texto
        preferredContentSize = CGSize(width: 345, height: 275)
    }
    
    

}
