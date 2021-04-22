//
//  ViewControllerZenGame.swift
//  ConTilde
//
//  Created by Marcos Quintero on 20/04/21.
//
import UIKit

class ViewControllerZen: UIViewController {

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
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
