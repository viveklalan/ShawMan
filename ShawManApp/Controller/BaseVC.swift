//
//  BaseVC.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import UIKit
import NVActivityIndicatorView

class BaseVC: UIViewController {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicatorView : NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .semiCircleSpin, color: .cyan, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //show indicator view
    func showProgressIndicator(){
        container  = UIView()
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColorFromHex(rgbValue : 0xffffff, alpha: 0.7)
        activityIndicatorView.center = view.center
        container.addSubview(activityIndicatorView)
        view.addSubview(container)
        activityIndicatorView.startAnimating()
    }
    
    //hide indicator view
    func hideProgressIndicator(){
        activityIndicatorView.stopAnimating()
        container.removeFromSuperview()
    }
    
    // Define UIColor from hex value
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //dismisskeyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //get title and messgae and show alert
    func showAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

