//
//  ViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/27.
//

import UIKit

enum PopupMode {
    case CreateLabel
    case Milestone
    case EditLabel
}

protocol PopupLabelViewControllerDelegate: class {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.LabelItem)
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.EditLabelItem)
}

protocol PopupMilestoneViewControllerDelegate: class {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.MilestoneItem)
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.EditMilestoneItem)
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
    var mode: PopupMode = .CreateLabel
    weak var labelDelegate: PopupLabelViewControllerDelegate?
    weak var milestoneDelegate: PopupMilestoneViewControllerDelegate?
    var displayedLabel: ListLabels.FetchLists.ViewModel.DisplayedLabel?
    var displayedMilestone: ListMilestones.FetchLists.ViewModel.DisplayedMilestone?
    
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK:- Setup by Mode
    private func setup() {
        if mode == .CreateLabel || mode == .EditLabel{
            setupLabelMode()
        }
        else {
            setupMilestoneMode()
        }
        contentSizeInPopup = CGSize(width: 300, height: 280)
        landscapeContentSizeInPopup = CGSize(width: 300, height: 200)
    }
    
    private func setupLabelMode() {
        totalLabel[2].text = "색상"
        descriptionTextField.isHidden = true
        if mode == .EditLabel {
            titleTextField.text = displayedLabel?.name
            detailTestField.text = displayedLabel?.description
            labelColorField.text = displayedLabel?.color.components(separatedBy: "#")[1]
            colorPickerButton.backgroundColor = UIColor(hexString: labelColorField.text!)
        }
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
    
    @IBAction func onSaveButtonPressed(_ sender: UIButton) {
        // 제목이 비어있을 때 error 처리 해주어야 함.
            // ex : firstresponder 넘겨줘서 입력 가능하게
        
        
        // force unwrapping 해결하기
        if mode == .CreateLabel {
            let newLabel = PopupItem.LabelItem(
                title: titleTextField.text!,
                description: detailTestField.text!,
                color: "#\(labelColorField.text!)"
            )
            dismiss(animated: true, completion: {
                self.labelDelegate?.popupViewController(self, didFinishAdding: newLabel)
            })
        } else if mode == .EditLabel {
            let editLabel = PopupItem.EditLabelItem(
                id: displayedLabel!.id,
                title: titleTextField.text!,
                description: detailTestField.text!,
                color: "#\(labelColorField.text!)")
            dismiss(animated: true, completion: {
                self.labelDelegate?.popupViewController(self, didFinishEditing: editLabel)
            })
        }
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
