//
//  ViewControllerZenGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 20/04/21.
//
import UIKit

class ViewControllerZen: UIViewController, UIPopoverPresentationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        upSwipe.direction = .up
        downSwipe.direction = .down
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playGame(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ZenGame") as! ViewControllerZenGame
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func btJugarPlay(_ sender: UIButton) {
        playGame(sender)
    }
    
    
    //MARK: - Swipe Controller
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if sender.direction == .up {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ZenGame") as! ViewControllerZen
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }
        
        if sender.direction == .down {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    // MARK: - Navigation

    let explicacion = "En el modo de juego Zen no hay cronómetros ni partidas perdidas, es el modo perfecto para practicar sin estrés. Tu mejor racha es guardada"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverZen"{
            let vistaPopOver = segue.destination as! ViewControllerComoJugar
            vistaPopOver.popoverPresentationController!.delegate = self
            vistaPopOver.texto = explicacion
        }
    }
    
    
    // MARK:- Metodos para PopOver
 
    func adaptivePresentationStyle (for controller:
    UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
