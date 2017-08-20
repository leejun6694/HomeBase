//
//  TeamNameViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class TeamNameViewController: UIViewController {
    
    // MARK: Properties
    
    fileprivate lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "팀 이름을 등록하세요 (2 - 10자)"
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
        
        nextButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        
        return nextButton
    }()
    
    // MARK: Actions
    
    @objc fileprivate func clickNextButton(_ sender: AnyObject) {
        let currentCount = self.nameTextField.text?.characters.count ?? 0
        
        if currentCount < 2 {
            let alertController = UIAlertController(
                title: "",
                message: "팀 명은 최소 2글자 입니다",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            let teamImageViewController = storyboard?.instantiateViewController(
                withIdentifier: "TeamImageViewController") as? TeamImageViewController
            
            teamImageViewController?.teamName = self.nameTextField.text ?? ""
            self.navigationController?.pushViewController(teamImageViewController!, animated: false)
        }
    }
    
    @objc fileprivate func clickView(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.view.addSubview(nameTextField)
        self.nameTextField.delegate = self
        self.view.addSubview(nextButton)
        
        self.view.addConstraints(nameTextFieldConstraints())
        self.view.addConstraints(nextButtonConstraint())
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
}

// MARK: Delegate

extension TeamNameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.characters.count ?? 0
        let replacementCount = currentCount + string.characters.count - range.length
        
        if replacementCount <= 10 {
            return true
        }
        else {
            let alertController = UIAlertController(title: "", message: "팀 명은 최대 10글자 입니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
            
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
        let centerXConstraint = NSLayoutConstraint(item: nameTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: nameTextField, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.9, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint]
    }
    
    fileprivate func nextButtonConstraint() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.1, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint]
    }
}
