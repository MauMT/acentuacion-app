//
//  ViewControllerClassicGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 21/04/21.
//

import UIKit

class ViewControllerClassicGame: UIViewController {

    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbPalabra: UILabel!
    
    // Lista de palabras de prueba
    var listaPalabras = [Palabra]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ruta = Bundle.main.path(forResource: "palabrasJSON", ofType: "json")!
        
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: ruta))
            listaPalabras = try JSONDecoder().decode([Palabra].self, from: data)
        } catch {
            print("Error al cargar el archivo")
        }
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        listaPalabras.shuffle()
        lbPalabra?.text = listaPalabras[listaPalabras.count - 1].palabra
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Boton volver
    
    @IBAction func volver(_ sender: UIButton) {
        dismissGame()
    }
    
    func dismissGame(){
        self.salvarPuntaje()
        self.dismiss(animated: true, completion: nil)
    }
    
    func salvarPuntaje(){
        
    }
    
    //MARK: - Swipe Controller
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            actualizarPuntaje(opcion: false)
        }
        
        if sender.direction == .right {
            actualizarPuntaje(opcion: true)
        }
    }
    
    
    //MARK: - Juego
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
                let alerta = UIAlertController(title: "Error", message: "Opcion incorrecta, puntaje de: " + String(puntos), preferredStyle: .alert)
                
                let accion = UIAlertAction(title: "Change Mode", style: .default, handler: {_ in
                    self.dismissGame()
                })
                
                let playAgain = UIAlertAction(title: "Play Again", style: .cancel, handler: {_ in
                    self.salvarPuntaje()
                    puntos = 0
                })
                
                alerta.addAction(playAgain)
                alerta.addAction(accion)
                
                present(alerta, animated: true, completion: nil)
                
            }
            lbPuntos.text = String(puntos)
            if (listaPalabras.count > 1) {
                listaPalabras.popLast()
                lbPalabra.text? = listaPalabras[listaPalabras.count - 1].palabra
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
