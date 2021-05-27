 //
//  ViewControllerZenGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 20/04/21.
//
import UIKit
import Koloda
import AVFoundation

class ViewControllerZenGame: UIViewController {
    
    @IBOutlet var lbMasPunto: UILabel!
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    @IBOutlet var kolodaView: KolodaView!
    @IBOutlet weak var lbPuntos: UILabel!
    
    // Lista de palabras de prueba
    var listaPalabras = [Palabra]()
    struct Puntaje: Codable{
        var name: String
        var points: Int
    }
    let defaults = UserDefaults.standard
    var puntaje = [Puntaje]()
    var nombre: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lbMasPunto.alpha = 0
        lbMasPunto.textColor = .systemGreen

        
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
        
        if let data = defaults.data(forKey: "puntajeZen") {
            puntaje = try! PropertyListDecoder().decode([Puntaje].self, from: data)
        }
        
        nombre = defaults.string(forKey: "name") ?? "Einstein"

        
        cargaPalabras()
        
        listaPalabras.shuffle()

        kolodaView.countOfVisibleCards = 2
        kolodaView.backgroundCardsTopMargin = 0
        kolodaView.dataSource = self
        kolodaView.delegate = self
        // Do any additional setup after loading the view.
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
            defaults.set(data, forKey: "puntajeZen")
        }
        
    }
    
    //MARK: - Boton volver
    
    @IBAction func volver(_ sender: UIButton) {
        dismissGame()
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
                audioPlayer.play()
                puntos = puntos + 1
                UIView.animate(withDuration: 0.5, animations: {
                    self.lbMasPunto.alpha = 1
                }, completion: {_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.lbMasPunto.alpha = 0
                    })
                })
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
                    self.salvarPuntaje()
                    self.dismissGame()
                })
                
                let playAgain = UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
                })
                
                alerta.addAction(playAgain)
                alerta.addAction(accion)
                
                present(alerta, animated: true, completion: nil)
            }
            lbPuntos.text = String(puntos)

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
 
 extension ViewControllerZenGame: KolodaViewDelegate {
     func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
         // kolodaView.reloadData()
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

 extension ViewControllerZenGame: KolodaViewDataSource {
   
   func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
     print("count = " + String(listaPalabras.count))
     return listaPalabras.count
   }
     
     
   
   func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
     let viewMain = UIView(frame: kolodaView.frame)
     viewMain.backgroundColor = .systemGray6
     let titleLabel = UILabel(frame: CGRect(x: 0 , y: 25, width: viewMain.frame.width, height: 80))
     
     titleLabel.text = listaPalabras[index].palabra
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

