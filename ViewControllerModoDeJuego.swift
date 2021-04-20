//
//  ViewControllerModoDeJuego.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit

class ViewControllerModoDeJuego: UIViewController {

    @IBOutlet weak var lbModoDeJuego: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
            downSwipe.direction = .down
            upSwipe.direction = .up
            leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .down
        {
           print("Swipe down")
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }

        if sender.direction == .up
        {
           print("Swipe up")
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if lbModoDeJuego.text! == "Classic" {
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Classic") as! ViewControllerClassic

                self.present(resultViewController, animated:true, completion:nil)
            }
            else if lbModoDeJuego.text! == "Time Attack" {
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Time Attack") as! ViewControllerTimeAttack

                self.present(resultViewController, animated:true, completion:nil)
            }

        }
        
        if sender.direction == .left {
            
            if lbModoDeJuego.text! == "Classic" {
                lbModoDeJuego.text! = "Time Attack"
            }else if lbModoDeJuego.text! == "Time Attack" {
                lbModoDeJuego.text! = "Zen"
            }else {
                lbModoDeJuego.text! = "Classic"
            }
        }
        
        if sender.direction == .right {
            
            if lbModoDeJuego.text! == "Classic" {
                lbModoDeJuego.text! = "Zen"
            }else if lbModoDeJuego.text! == "Time Attack" {
                lbModoDeJuego.text! = "Classic"
            }else {
                lbModoDeJuego.text! = "Time Attack"
            }
        }
    }


}
