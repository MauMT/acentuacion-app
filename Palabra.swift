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
    
    init(palabra : String, correcta : Bool) {
        self.palabra = palabra
        self.correcta = correcta
    }
}
