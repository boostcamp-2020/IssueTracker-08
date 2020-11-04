//
//  ViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/27.
//

import UIKit

class PopUpViewController: UIViewController {
    var coordinator: String = "" {
        willSet {
            if newValue == "Label" { setupLabelMode() }
            else { setupMilestoneMode() }
        }
    }
    var router: (PopUpDataPassing)?
    
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
      
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let router = PopUpRouter()
        viewController.router = router
        router.viewController = viewController
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentSizeInPopup = CGSize(width: 300, height: 280)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 200)
        coordinator = router!.coordinator
    }
    
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
        else {
            if coordinator == "Label" { labelColorField.becomeFirstResponder() }
            else { descriptionTextField.becomeFirstResponder() }
        }
        return true
    }
    
    private func changeBtnColor(colorText: String) {
        colorPickerButton.backgroundColor = UIColor(hexString: colorText)
    }
}
