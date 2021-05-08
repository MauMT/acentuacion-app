//
//  ViewControllerTimeAttack.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//
import UIKit

class ViewControllerTimeAttack: UIViewController, UIPopoverPresentationControllerDelegate {

    
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
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TimeAttackGame") as! ViewControllerTimeAttackGame
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    
    }
    
    @IBAction func btJugarPlay(_ sender: UIButton) {
        playGame(sender)
    }
    
    let explicacion = "En el modo de juego Time Attack tienes un cronómetro con valor inicial de 10 segundos, cada vez que aciertas si una palabra está bien escrita o no, de acuerdo con las reglas de acentuación, ganas un punto y se suman 3 segundos al cronómetro, pero si fallas pierdes 3 segundos. El juego termina cuando el cronómetro llega a 0."
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverTimeAttack" {
            let vistaPopOver = segue.destination as! ViewControllerComoJugar
            vistaPopOver.popoverPresentationController!.delegate = self
            vistaPopOver.texto = explicacion
        }
    }
    
    //MARK: - Swipe Controller
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if sender.direction == .up {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TimeAttackGame") as! ViewControllerTimeAttack
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
