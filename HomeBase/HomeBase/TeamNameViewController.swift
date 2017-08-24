//
//  TeamNameViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class TeamNameViewController: UIViewController, CustomAlertShowing {
    
    var viewController: UIViewController {
        return self
    }
    
    // MARK: Properties
    
    fileprivate lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.font = UIFont(name: "System", size: 22.0)
        nameTextField.textAlignment = .center
        nameTextField.borderStyle = .none
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTextField
    }()
    
    fileprivate lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        
        nextButton.setTitle("next", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "System", size: 20.0)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.addTarget(self, action: #selector(nextButtonDidTapped(_:)), for: .touchUpInside)
        
        return nextButton
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = .nameTextFieldPlaceholder
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.view.addSubview(nameTextField)
        self.view.addConstraints(nameTextFieldConstraints())
        self.nameTextField.delegate = self
        
        self.view.addSubview(nextButton)
        self.view.addConstraints(nextButtonConstraint())
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundViewDidTapped(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Actions
    
    @objc private func nextButtonDidTapped(_ sender: AnyObject) {
        let currentCount = self.nameTextField.text?.characters.count ?? 0
        
        if currentCount < 2 {
            showAlertOneButton(message: .alertMessageOfShortageTeamName)
        } else {
            let teamImageViewController = storyboard?.instantiateViewController(
                withIdentifier: .teamImageViewController) as? TeamImageViewController
            
            teamImageViewController?.teamName = self.nameTextField.text ?? ""
            self.navigationController?.pushViewController(teamImageViewController!, animated: true)
        }
    }
    
    @objc private func backgroundViewDidTapped(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
}

// MARK: Delegate

extension TeamNameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCount = textField.text?.characters.count ?? 0
        let replacementCount = currentCount + string.characters.count - range.length
        
        if replacementCount <= 10 {
            return true
        } else {
            showAlertOneButton(message: .alertMessageOfAbundanceTeamName)
                        
            return false
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
}

// MARK: Layout Constraints

extension TeamNameViewController {
    
    fileprivate func nameTextFieldConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .centerX, relatedBy: .equal,
            toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        let centerYConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .centerY, relatedBy: .equal,
            toItem: view, attribute: .centerY, multiplier: 0.9, constant: 0.0)
        
        let widthConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .width, relatedBy: .equal,
            toItem: view, attribute: .width, multiplier: 0.9, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint]
    }
    
    fileprivate func nextButtonConstraint() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nextButton, attribute: .centerX, relatedBy: .equal,
            toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        let centerYConstraint = NSLayoutConstraint(
            item: nextButton, attribute: .centerY, relatedBy: .equal,
            toItem: view, attribute: .centerY, multiplier: 1.1, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint]
    }
}
