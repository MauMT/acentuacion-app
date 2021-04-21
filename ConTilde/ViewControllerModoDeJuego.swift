//
//  ViewControllerModoDeJuego.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit

class ViewControllerModoDeJuego: UIViewController {

    @IBOutlet weak var lbModoDeJuego: UILabel!
    @IBOutlet weak var imgModo: UIImageView!
    
    
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
        imgModo.image = UIImage(named: "classicTemp.jpg")
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    //MARK: - Swipe Controller
    
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
                resultViewController.modalPresentationStyle = .fullScreen
                self.present(resultViewController, animated:true, completion:nil)
            }
            else if lbModoDeJuego.text! == "Time Attack" {
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Time Attack") as! ViewControllerTimeAttack
                resultViewController.modalPresentationStyle = .fullScreen
                self.present(resultViewController, animated:true, completion:nil)
            }else{
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Zen") as! ViewControllerZen
                resultViewController.modalPresentationStyle = .fullScreen
                self.present(resultViewController, animated:true, completion:nil)
            }

        }
        
        if sender.direction == .left {
            
            if lbModoDeJuego.text! == "Classic" {
                lbModoDeJuego.text! = "Time Attack"
                imgModo.image! = UIImage(named: "time.jpg")!
            }else if lbModoDeJuego.text! == "Time Attack" {
                lbModoDeJuego.text! = "Zen"
                imgModo.image! = UIImage(named: "zen.jpg")!
            }else {
                lbModoDeJuego.text! = "Classic"
                imgModo.image! = UIImage(named: "classicTemp.jpg")!
            }
        }
        
        if sender.direction == .right {
            
            if lbModoDeJuego.text! == "Classic" {
                lbModoDeJuego.text! = "Zen"
                imgModo.image! = UIImage(named: "zen.jpg")!
            }else if lbModoDeJuego.text! == "Time Attack" {
                lbModoDeJuego.text! = "Classic"
                imgModo.image! = UIImage(named: "classicTemp.jpg")!
            }else {
                lbModoDeJuego.text! = "Time Attack"
                imgModo.image! = UIImage(named: "time.jpg")!
            }
        }
    }


    @IBAction func changeView(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if lbModoDeJuego.text! == "Classic" {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Classic") as! ViewControllerClassic
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }
        else if lbModoDeJuego.text! == "Time Attack" {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Time Attack") as! ViewControllerTimeAttack
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }else{
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Zen") as! ViewControllerZen
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func changeViewArrow(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if lbModoDeJuego.text! == "Classic" {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Classic") as! ViewControllerClassic
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }
        else if lbModoDeJuego.text! == "Time Attack" {
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Time Attack") as! ViewControllerTimeAttack
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }else{
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Zen") as! ViewControllerZen
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    
    @IBAction func goBackArrow(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
