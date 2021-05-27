//
//  Palabra.swift
//  ConTilde
//
//  Created by Marcos Quintero on 20/04/21.
//
import UIKit

class Palabra: NSObject, Codable {
    var palabra : String
    var correcta : Bool
    var error : Int
    
    init(palabra : String, correcta : Bool, error: Int) {
        self.palabra = palabra
        self.correcta = correcta
        self.error = error
    }
}
