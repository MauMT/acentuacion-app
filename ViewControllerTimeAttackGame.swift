//
//  ViewControllerTimeAttack.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//
import UIKit
import Koloda
import AVFoundation

class ViewControllerTimeAttackGame: UIViewController {
    
    @IBOutlet var lbMasPunto: UILabel!
    @IBOutlet var lbMasTiempo: UILabel!
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
        
        lbMasPunto.alpha = 0
        lbMasPunto.textColor = .systemGreen
        lbMasTiempo.alpha = 0
        
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
        
        if let data = defaults.data(forKey: "puntajeTime") {
            puntaje = try! PropertyListDecoder().decode([Puntaje].self, from: data)
        }
        nombre = defaults.string(forKey: "name") ?? "Einstein"

        
        cargaPalabras()
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
        listaPalabras.shuffle()
   
        kolodaView.countOfVisibleCards = 2
        kolodaView.backgroundCardsTopMargin = 0
        // Do any additional setup after loading the view.
        kolodaView.dataSource = self
        kolodaView.delegate = self

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
    
    
    
    //MARK: - Juego
    
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            if timeRemaining <= 3 {
                lbTiempo.textColor = .systemRed
            }
        } else if presenting == false {
            if var puntos = Int(lbPuntos.text!) {
                let alerta = UIAlertController(title: "Se acab?? el tiempo", message: "Puntaje: " + String(puntos), preferredStyle: .alert)
                              
                let accion = UIAlertAction(title: "Salir", style: .default, handler: {_ in
                    self.presenting = true
                    self.dismissGame()
                })

                let playAgain = UIAlertAction(title: "Nueva Partida", style: .cancel, handler: {_ in
                    self.salvarPuntaje()
                    puntos = 0
                    self.lbPuntos.text = String(puntos)
                    self.cargaPalabras()
                    self.listaPalabras.shuffle()
                    self.kolodaView.resetCurrentCardIndex()
                    self.timeRemaining = 10
                    self.lbTiempo?.text = String(self.timeRemaining)
                    self.lbTiempo.textColor = .black
                })
                
                 

                alerta.addAction(playAgain)
                alerta.addAction(accion)

                present(alerta, animated: true, completion: nil)
            }
        }
        lbTiempo?.text = String(timeRemaining)
    }
    
    
    
    @IBAction func opcionSi(_ sender: UIButton) {
        kolodaView.swipe(SwipeResultDirection.right)
    }
    
    @IBAction func opcionNo(_ sender: UIButton) {
        kolodaView.swipe(SwipeResultDirection.left)
    }
    
    func actualizarPuntaje(opcion: Bool, indice: Int) {
        let respuesta = listaPalabras[indice].correcta
        
        if var puntos = Int(lbPuntos.text!) {
            if (opcion == respuesta) {
                puntos = puntos + 1
                // play al sonido
                audioPlayer.play()
                // animacion de puntos
                UIView.animate(withDuration: 0.5, animations: {
                    self.lbMasPunto.alpha = 1
                }, completion: {_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.lbMasPunto.alpha = 0
                    })
                })
                timeRemaining += 3
                // animacion de tiempo
                lbMasTiempo.text = "+3"
                lbMasTiempo.textColor = .systemGreen
                UIView.animate(withDuration: 0.5, animations: {
                    self.lbMasTiempo.alpha = 1
                }, completion: {_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.lbMasTiempo.alpha = 0
                    })
                })
                if(timeRemaining > 3){
                    lbTiempo.textColor = .black
                }
            } else {
                audioPlayer2.play()
                lbMasTiempo.text = "-3"
                lbMasTiempo.textColor = .red
                UIView.animate(withDuration: 0.5, animations: {
                    self.lbMasTiempo.alpha = 1
                }, completion: {_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.lbMasTiempo.alpha = 0
                    })
                })
                var err = ""
                if listaPalabras[indice].error == 0 {
                    err = "Regla general de acentuacion"
                } else if listaPalabras[indice].error == 1 {
                    err = "Regla de hiatos y diptongos"
                } else if listaPalabras[indice].error == 2 {
                    err = "Casos especiales de acentuacion"
                }
                let alerta = UIAlertController(title: "Opci??n Incorrecta", message: "Consulta la regla: " + err + "\nPuntaje: " + String(puntos), preferredStyle: .alert)
                
                let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                present(alerta, animated: true, completion: nil)
                timeRemaining -= 3
                
            }
            lbTiempo?.text = String(timeRemaining)
            lbPuntos?.text = String(puntos)
            
        }
        
    }
    
}

// MARK: - Card Methods

extension ViewControllerTimeAttackGame: KolodaViewDelegate {
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

extension ViewControllerTimeAttackGame: KolodaViewDataSource {
  
  func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
    print("count = " + String(listaPalabras.count))
    return listaPalabras.count
  }
    
    
  
  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    let viewMain = UIView(frame: kolodaView.frame)
    viewMain.backgroundColor = .systemGray6
    let titleLabel = UILabel(frame: CGRect(x: 0 , y: 0, width: viewMain.frame.width, height: viewMain.frame.height))
    
    titleLabel.text = listaPalabras[index].palabra
    if listaPalabras[index].palabra.count >= 20 {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 15)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
    }
    if listaPalabras[index].palabra.count >= 15  {
        titleLabel.font = UIFont(name: "Airbnb Cereal App Bold", size: 18)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
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
