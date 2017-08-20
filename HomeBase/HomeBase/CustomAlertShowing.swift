//
//  CustomAlertShowing.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 20..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

protocol CustomAlertShowing: NSObjectProtocol {
    var viewController: UIViewController { get }
}

extension CustomAlertShowing {
    
    func showAlertOneButton(title: String = "", message: String = "") {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: ({ _ in
            alertController.dismiss(animated: true, completion: nil)
        })))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertTwoButton(
        title: String = "", message: String = "", okAction: @escaping ((UIAlertAction) -> Void)) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: okAction))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
