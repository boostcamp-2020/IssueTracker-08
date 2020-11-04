//
//  ViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/27.
//

import UIKit

enum PopupMode {
    case Label
    case Milestone
}

protocol PopupViewControllerDelegate: class {
    func popupViewControllerDidCancel(_ controller: PopUpViewController)
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem)
}

class PopUpViewController: UIViewController {
     
    // MARK:- IBOutlets
    @IBOutlet var totalLabel: [UILabel]!
    @IBOutlet weak var colorHexLabel: UILabel!
    @IBOutlet weak var labelColorField: UITextField! {
        didSet { labelColorField.delegate = self }
    }
    @IBOutlet weak var titleTextField: UITextField! {
        didSet { titleTextField.delegate = self }
    }
    @IBOutlet weak var detailTestField: UITextField! {
        didSet { detailTestField.delegate = self }
    }
    @IBOutlet weak var descriptionTextField: UITextField! {
        didSet { descriptionTextField.delegate = self }
    }
    
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK:- Properties
    var mode: PopupMode = .Label
    weak var delegate: PopupViewControllerDelegate?
    
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK:- Setup by Mode
    private func setup() {
        if mode == .Label { setupLabelMode() }
        else { setupMilestoneMode() }
        contentSizeInPopup = CGSize(width: 300, height: 280)
        landscapeContentSizeInPopup = CGSize(width: 300, height: 200)
    }
    
    private func setupLabelMode() {
        totalLabel[2].text = "색상"
        descriptionTextField.isHidden = true
    }
    
    private func setupMilestoneMode() {
        totalLabel[1].isHidden = true
        totalLabel[3].isHidden = false
        totalLabel[2].text = "설명"
        colorPickerButton.isHidden = true
        reloadButton.isHidden = true
        labelColorField.isHidden = true
        colorHexLabel.isHidden = true
    }
    
    //MARK:- IBActions
    @IBAction func btnClickReload(_ sender: Any) {
        let reloadColor = randomColor()
        colorPickerButton.backgroundColor = reloadColor
        labelColorField.text = reloadColor.toHexString()
    }
    
    @IBAction func btnClickColorPicker(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.view.backgroundColor!
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func btnResetAllData(_ sender: Any) {
        titleTextField.text = ""
        detailTestField.text = ""
        descriptionTextField.text = ""
    }
}

extension PopUpViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectColor = viewController.selectedColor
        colorPickerButton.backgroundColor = selectColor
        labelColorField.text = selectColor.toHexString()
    }
}

extension PopUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "colorText" {
            changeBtnColor(colorText: textField.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let identifier = textField.restorationIdentifier
        if identifier == "colorText" {
            changeBtnColor(colorText: textField.text!)
            textField.resignFirstResponder()
        }
        else if identifier == "titleText" {
            detailTestField.becomeFirstResponder()
        }
//        else {
//            if coordinator == "Label" { labelColorField.becomeFirstResponder() }
//            else { descriptionTextField.becomeFirstResponder() }
//        }
        return true
    }
    
    private func changeBtnColor(colorText: String) {
        colorPickerButton.backgroundColor = UIColor(hexString: colorText)
    }
}
