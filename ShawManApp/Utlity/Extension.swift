//
//  Extension.swift
//  ShawManApp
//
//  Created by Jai Mataji on 02/03/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addRadius(brRadius: CGFloat = 5.0) -> Void {
        layer.cornerRadius = brRadius
    }
    
    func addBorder(brWidth: CGFloat = 0.5, brColor: UIColor = .black) -> Void {
        layer.borderWidth = brWidth
        layer.borderColor = brColor.cgColor
    }
    
    func addBorderWithRadius(brWidth: CGFloat = 0.5, brColor: UIColor = .black, brRadius:CGFloat = 5) -> Void {
        layer.cornerRadius = brRadius
        layer.borderWidth = brWidth
        layer.borderColor = brColor.cgColor
    }
    
    func addBorderWithRadiusAndShadow(brWidth: CGFloat = 0.5, brColor: UIColor = .black, brRadius:CGFloat = 5) -> Void {
        layer.cornerRadius = brRadius
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.masksToBounds = false
        layer.shadowRadius = brRadius
        layer.shadowOpacity = 0.7
    }
    
}
