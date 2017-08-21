//
//  CustomAlertShowing.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 20..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

/// The group of methods that are easy to use UIAlertControllers
protocol CustomAlertShowing: NSObjectProtocol {
    var viewController: UIViewController { get }
}

extension CustomAlertShowing {
    
    /// UIAlertController with only one action that confirm
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: Descriptive text that provides additional details about the reason for the alert.
    func showAlertOneButton(title: String = "", message: String = "") {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: ({ _ in
            alertController.dismiss(animated: true, completion: nil)
        })))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /// UIAlertController with the two action that cancel and confirm
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: Descriptive text that provides additional details about the reason for the alert.
    ///   - confirmAction: A block to execute when the user selects the confirmation action. This block has no return value and takes the selected action object as its only parameter.
    func showAlertTwoButton(
        title: String = "", message: String = "", confirmAction: @escaping ((UIAlertAction) -> Void)) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: confirmAction))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
