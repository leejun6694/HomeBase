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

extension CustomAlertShowing where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}

extension CustomAlertShowing {
    
    /// UIAlertController with only one action that confirm
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: Descriptive text that provides additional details about the reason for the alert.
    func showAlertOneButton(title: String = "", message: String = "") {
        showAlertTwoButton(title: title, message: message, cancelActionTitle: .confirmActionTitle )
    }
    
    /// UIAlertController with the two action that cancel and confirm
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: Descriptive text that provides additional details about the reason for the alert.
    ///   - cancelActionTitle: The text to use for the cancel button title.
    ///   - confirmActionTitle: The text to use for the confirm button title.
    ///   - confirmAction: A block to execute when the user selects the confirmation action. This block has no return value and takes the selected action object as its only parameter.
    func showAlertTwoButton(
        title: String = "",
        message: String = "",
        cancelActionTitle: String? = nil,
        confirmActionTitle: String? = nil,
        confirmAction: @escaping ((UIAlertAction) -> Void) = { _ in }) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancelTitle = cancelActionTitle {
            alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        }
        
        if let okTitle = confirmActionTitle {
            alertController.addAction(UIAlertAction(title: okTitle, style: .default, handler: confirmAction))
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
