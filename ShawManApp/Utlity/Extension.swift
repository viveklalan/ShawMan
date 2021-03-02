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
    
    func addBorderWithRadiusAndShadow() -> Void {
        layer.cornerRadius = 20.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.7
    }
    
}
