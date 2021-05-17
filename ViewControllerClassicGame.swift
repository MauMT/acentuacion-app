//
//  ViewControllerClassicGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 21/04/21.
//

import UIKit
import Koloda

class ViewControllerClassicGame: UIViewController {

    @IBOutlet var kolodaView: KolodaView!
    
    struct Puntaje: Codable {
        var name: String
        var points: Int
    }
    @IBOutlet weak var lbPuntos: UILabel!
    
    // Lista de palabras de prueba
    var listaPalabras = [Palabra]()

    let defaults = UserDefaults.standard
    var puntaje = [Puntaje]()
    var nombre : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let data = defaults.data(forKey: "puntajeClassic") {
            puntaje = try! PropertyListDecoder().decode([Puntaje].self, from: data)
        }
        nombre = defaults.string(forKey: "name") ?? "Einstein"
        
         cargaPalabras()
        
       /*
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        */
        
        listaPalabras.shuffle()

        
        for pal in listaPalabras {
            print(pal.palabra)
        }
        
        kolodaView.countOfVisibleCards = 2
        kolodaView.backgroundCardsTopMargin = 0
        // Do any additional setup after loading the view.
        kolodaView.dataSource = self
        kolodaView.delegate = self
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
    
    //MARK: - Boton volver
    
    @IBAction func volver(_ sender: UIButton) {
        dismissGame()
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
            defaults.set(data, forKey: "puntajeClassic")
        }
    }
    
    /*
    //MARK: - Swipe Controller
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            actualizarPuntaje(opcion: false)
        }
        
        if sender.direction == .right {
            actualizarPuntaje(opcion: true)
        }
    }
    */
    
    
    //MARK: - Juego
    @IBAction func opcionSi(_ sender: UIButton) {
        kolodaView.swipe(SwipeResultDirection.right)
    }
    
    @IBAction func opcionNo(_ sender: UIButton) {
        kolodaView.swipe(SwipeResultDirection.left)
    }
    
    func actualizarPuntaje(opcion : Bool, indice: Int) {
        let respuesta = listaPalabras[indice].correcta
        if var puntos = Int(lbPuntos.text!) {
            if (opcion == respuesta) {
                puntos = puntos + 1
            } else {
                let alerta = UIAlertController(title: "Error", message: "Opción incorrecta\nPuntaje: " + String(puntos), preferredStyle: .alert)
                
                let accion = UIAlertAction(title: "Cambiar Modo de Juego", style: .default, handler: {_ in
                    self.dismissGame()
                })
                
                let playAgain = UIAlertAction(title: "Nueva Partida", style: .cancel, handler: {_ in
                    self.salvarPuntaje()
                    puntos = 0
                    self.lbPuntos.text = String(puntos)
                    self.cargaPalabras()
                    self.listaPalabras.shuffle()
                    self.kolodaView.resetCurrentCardIndex()
                    
                })
                
                alerta.addAction(playAgain)
                alerta.addAction(accion)
                
                present(alerta, animated: true, completion: nil)
                
            }
            lbPuntos.text = String(puntos)
            if indice >= listaPalabras.count - 1 {
                //listaPalabras.shuffle()
                //kolodaView.resetCurrentCardIndex()
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

// MARK: - Card Methods

extension ViewControllerClassicGame: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        // kolodaView.reloadData()
        listaPalabras.shuffle()
        kolodaView.resetCurrentCardIndex()
    }
  
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let alert = UIAlertController(title: listaPalabras[index].palabra, message: listaPalabras[index].palabra, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    internal func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        if direction == SwipeResultDirection.left {
            actualizarPuntaje(opcion: false, indice: index)

        } else {
            actualizarPuntaje(opcion: true, indice: index)

        }
       

    }
    
}

extension ViewControllerClassicGame: KolodaViewDataSource {
  
  func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
    print("count = " + String(listaPalabras.count))
    return listaPalabras.count
  }
    
  
  
  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    ///let grisClaro = CIColor(red: 230, green: 230, blue: 230, alpha: 1)
    
    let viewMain = UIView(frame: kolodaView.frame)
    viewMain.backgroundColor = .systemGray6
    let titleLabel = UILabel(frame: CGRect(x: 0 , y: 35, width: viewMain.frame.width, height: 50))
    
    titleLabel.text = listaPalabras[index].palabra
    if listaPalabras[index].palabra.count >= 9 {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 36)
    } else {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 42)

    }
    titleLabel.textColor = UIColor.black
    titleLabel.backgroundColor = .systemGray6
    titleLabel.textAlignment = NSTextAlignment.center
    viewMain.addSubview(titleLabel)

    viewMain.layer.cornerRadius = 20
    viewMain.clipsToBounds = true
    print("indice es " + String(index))
    return viewMain
  }
    
}
