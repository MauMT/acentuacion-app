//
//  ViewControllerTimeAttack.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//
import UIKit

class ViewControllerTimeAttackGame: UIViewController {

    
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbPalabra: UILabel!
    @IBOutlet weak var lbTiempo: UILabel!
    
    // Lista de palabras de prueba
    var listaPalabras = [Palabra]()
    struct Puntaje: Codable{
        var name: String
        var points: Int
    }
    let defaults = UserDefaults.standard
    var puntaje = [Puntaje]()
    var nombre: String!
    var presenting: Bool = false
    
    var timeRemaining : Int = 10
    var timer : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = defaults.data(forKey: "puntajeTime") {
            puntaje = try! PropertyListDecoder().decode([Puntaje].self, from: data)
        }
        nombre = defaults.string(forKey: "name")
        
        cargaPalabras()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
        listaPalabras.shuffle()
        lbPalabra?.text = listaPalabras[listaPalabras.count - 1].palabra
        

        // Do any additional setup after loading the view.
    }

    //MARK: - Boton volver
    
    @IBAction func volver(_ sender: UIButton) {
        dismissGame()
    }
    
    
    func cargaPalabras(){
        let ruta = Bundle.main.path(forResource: "palabrasJSON", ofType: "json")!
        
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: ruta))
            listaPalabras = try JSONDecoder().decode([Palabra].self, from: data)
        } catch {
            print("Error al cargar el archivo")
        }
    }

    func dismissGame(){
        self.salvarPuntaje()
        self.dismiss(animated: true, completion: nil)
    }
        
    func salvarPuntaje(){
        puntaje.append(Puntaje(name: nombre, points: Int(lbPuntos.text!)!))
        puntaje.sort { (lhs, rhs) in return lhs.points > rhs.points }
        if puntaje.count > 5 {
            puntaje.popLast()
        }
        if let data = try? PropertyListEncoder().encode(puntaje) {
            defaults.set(data, forKey: "puntajeTime")
        }
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
    
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else if presenting == false{
            if var puntos = Int(lbPuntos.text!) {
                let alerta = UIAlertController(title: "Se acabo el tiempo", message: "Puntaje de: " + String(puntos), preferredStyle: .alert)
                              
                let accion = UIAlertAction(title: "Change Mode", style: .default, handler: {_ in
                    self.presenting = true
                    self.dismissGame()
                })

                let playAgain = UIAlertAction(title: "Play Again", style: .cancel, handler: {_ in
                    self.salvarPuntaje()
                    puntos = 0
                    self.lbPuntos.text = String(puntos)
                    self.cargaPalabras()
                    if (self.listaPalabras.count > 1) {
                        self.listaPalabras.popLast()
                        self.lbPalabra.text? = self.listaPalabras[self.listaPalabras.count - 1].palabra
                    }
                    self.timeRemaining = 10
                    self.lbTiempo?.text = String(self.timeRemaining)
                })

                alerta.addAction(playAgain)
                alerta.addAction(accion)

                present(alerta, animated: true, completion: nil)
            }
        }
        lbTiempo?.text = String(timeRemaining)
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
                let alerta = UIAlertController(title: "Error", message: "Opcion incorrecta", preferredStyle: .alert)
                
                let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                present(alerta, animated: true, completion: nil)
                timeRemaining -= 3
                
            }
            lbTiempo?.text = String(timeRemaining)
            lbPuntos?.text = String(puntos)
            if (listaPalabras.count > 1) {
                listaPalabras.popLast()
                lbPalabra.text? = listaPalabras[listaPalabras.count - 1].palabra
            } else {
                cargaPalabras()
            }
            
        }
        
    }
    
}
