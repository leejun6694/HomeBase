//
//  TeamSettingViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 19..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class TeamSettingViewController: UIViewController, CustomAlertShowing {
    
    var viewController: UIViewController {
        return self
    }
    
    // MARK: Properties
    
    @IBOutlet var teamNameTextField: UITextField!
    fileprivate let teamInfo: TeamInfo? = TeamInfoDAO.shared.select()
    
    fileprivate lazy var teamImage: UIImage = {
        let teamImage = UIImage()
        
        return teamImage
    }()
    
    fileprivate lazy var didTeamImageChanging: Bool = {
        let didTeamImageChanging = false
        
        return didTeamImageChanging
    }()
    
    // MARK: Functions
    
    fileprivate func changeTeamImage() {
        showAlertOneButton(title: "팀 이미지 변경", message: "변경된 이미지를 적용하려면 Done을 누르세요")
    }
    
    fileprivate func changeTeamInfo(action: UIAlertAction) {
        if teamInfo?.teamName != teamNameTextField.text {
            TeamInfoDAO.shared.updateTeamName(updateTeamName: teamNameTextField.text ?? "")
        }
        
        if didTeamImageChanging == true {
            let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = documentsDirectories.first!
            
            let url: URL = documentDirectory.appendingPathComponent("TeamImage")
            
            if let data = UIImageJPEGRepresentation(teamImage, 0.8) {
                do {
                    try data.write(to: url, options: [.atomic])
                } catch {
                    print("Write Error : \(error)")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func clickChangeImageButton(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func clickCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickDoneButton(_ sender: UIBarButtonItem) {
        let countTextField = teamNameTextField.text?.characters.count ?? 0
        
        if countTextField < 2 {
            showAlertOneButton(message: "팀 명은 최소 2글자 입니다")
        }
        else {
            showAlertTwoButton(
                title: "팀 정보 수정",
                message: "팀 정보를 수정하시겠습니까?",
                cancelActionTitle: "취소",
                confirmActionTitle: "확인",
                confirmAction: changeTeamInfo)
        }
    }
    
    @IBAction func tapBackgroundView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MAKR: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameTextField.text = teamInfo?.teamName
        teamNameTextField.delegate = self
    }
}

// MARK: ImagePicker Delegate

extension TeamSettingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.allowsEditing = true
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            teamImage = selectedImage
            didTeamImageChanging = true
        }
        else if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            teamImage = selectedImage
            didTeamImageChanging = true
        }
        else {
            print("Picker Error")
        }
        
        dismiss(animated: true, completion: changeTeamImage)
    }
}

// MARK: TextField Delegate

extension TeamSettingViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.characters.count ?? 0
        let replacementCount = currentCount + string.characters.count - range.length
        
        if replacementCount <= 10 {
            return true
        }
        else {
            showAlertOneButton(message: "팀 명은 최대 10글자 입니다")
           
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}
