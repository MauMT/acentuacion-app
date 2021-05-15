//
//  ViewControllerClassic.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//


import UIKit

class ViewControllerClassic: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return puntaje.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaClassic")!
        cell.textLabel?.text = puntaje[indexPath.row].name
        cell.detailTextLabel?.text = String(puntaje[indexPath.row].points)
        return cell
    }
    
    
    struct Puntaje: Codable{
        var name: String
        var points: Int
    }
    let defaults = UserDefaults.standard
    var puntaje = [Puntaje]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        if let data = defaults.data(forKey: "puntajeClassic") {
            puntaje = try! PropertyListDecoder().decode([Puntaje].self, from: data)
        }
        tableview.reloadData()
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        upSwipe.direction = .up
        downSwipe.direction = .down
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
    }
    

    @IBAction func playGame(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ClassicGame") as! ViewControllerClassicGame
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    
    @IBAction func btJugarPlay(_ sender: UIButton) {
        playGame(sender)
    }
    let explicacion = "En el modo de juego Classic, cada vez que aciertas si una palabra está bien escrita o no, de acuerdo con las reglas de acentuación, ganas un punto.\nAl momento de fallar termina la partida y se guarda tu racha. Puedes ver tus mejores puntajes en el menú antes de iniciar el juego."
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverClassic"{
            let vistaPopOver = segue.destination as! ViewControllerComoJugar
            vistaPopOver.popoverPresentationController!.delegate = self
            vistaPopOver.texto = explicacion
        }
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if sender.direction == .up {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ClassicGame") as! ViewControllerClassicGame
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }
        
        if sender.direction == .down {
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    // MARK:- Metodos para PopOver
 
    func adaptivePresentationStyle (for controller:
    UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
