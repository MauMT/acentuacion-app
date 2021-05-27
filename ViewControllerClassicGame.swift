//
//  ViewControllerClassicGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 21/04/21.
//

import UIKit
import Koloda
import AVFoundation


class ViewControllerClassicGame: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
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
       
        
        // cargar el audio
        let doneSound = Bundle.main.path(forResource: "doneSound", ofType: "mp3")
        let errorSound = Bundle.main.path(forResource: "errorSound", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: doneSound!))
        } catch {
            print(error)
        }
        
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: errorSound!))
        } catch {
            print(error)
        }
        
        
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
                audioPlayer.play()
            } else {
                audioPlayer2.play()
                var err = ""
                if listaPalabras[indice].error == 0 {
                    err = "Regla general de acentuacion"
                } else if listaPalabras[indice].error == 1 {
                    err = "Regla de hiatos y diptongos"
                } else if listaPalabras[indice].error == 2 {
                    err = "Casos especiales de acentuacion"
                }
                let alerta = UIAlertController(title: "Opción Incorrecta", message: "Consulta la regla: " + err + "\nPuntaje: " + String(puntos), preferredStyle: .alert)
                
                let accion = UIAlertAction(title: "Salir", style: .default, handler: {_ in
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
    let titleLabel = UILabel(frame: CGRect(x: 0 , y: 25, width: viewMain.frame.width, height: 80))
    
    titleLabel.text = listaPalabras[index].palabra
    ///titleLabel.textAlignment = .center // no jala
    if listaPalabras[index].palabra.count >= 20 {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 15)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 3
    }
    if listaPalabras[index].palabra.count >= 15  {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 18)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 3
    } else if listaPalabras[index].palabra.count >= 8 {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 30)
    }else {
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
