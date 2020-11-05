//
//  ViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/27.
//

import UIKit

enum PopupMode {
    case CreateLabel
    case CreateMilestone
    case EditLabel
    case EditMilestone
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
        if mode == .EditMilestone {
            titleTextField.text = displayedMilestone?.title
            detailTestField.text = FormattedEditDateString(dueDate: (displayedMilestone?.dueDate)!)
            descriptionTextField.text = displayedMilestone?.content
        }
    }
    
    private func disMissLabel() {
        if mode == .CreateLabel {
            let newLabel = PopupItem.LabelItem(
                title: titleTextField.text!,
                description: detailTestField.text ?? nil,
                color: "#\(labelColorField.text!)"
            )
            labelDelegate?.popupViewController(self, didFinishAdding: newLabel)
        } else {
            let newLabel = PopupItem.EditLabelItem(
                id: displayedLabel!.id,
                title: titleTextField.text!,
                description: detailTestField.text ?? nil,
                color: "#\(labelColorField.text!)"
            )
            labelDelegate?.popupViewController(self, didFinishEditing: newLabel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    private func disMissMilestone() {
        if mode == .CreateMilestone {
            let newLabel = PopupItem.MilestoneItem(
                title: titleTextField.text!,
                dueDate: detailTestField.text!,
                content: descriptionTextField.text!
            )
            milestoneDelegate?.popupViewController(self, didFinishAdding: newLabel)
        } else {
            let newLabel = PopupItem.EditMilestoneItem(
                id: displayedMilestone!.id,
                title: titleTextField.text!,
                dueDate:detailTestField.text!,
                content: descriptionTextField.text!
            )
            milestoneDelegate?.popupViewController(self, didFinishEditing: newLabel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkLabel() -> Bool {
        if titleTextField.text!.isEmpty || labelColorField.text!.isEmpty {
            warningAlert()
            return false
        }
        return true
    }
    
    private func checkMilestone() -> Bool {
        if titleTextField.text!.isEmpty {
            warningAlert()
            return false
        }
        return true
    }
    
    private func warningAlert() {
        let alert = UIAlertController(title: "경고",
                                    message: "입력하지 않은 목록이 있습니다.",
                                    preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title:"Cancle", style: .default, handler: { (_) in })
        alert.addAction(cancleAction)
        present(alert, animated: true, completion:nil)
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
        if mode == .CreateLabel || mode == .EditLabel {
            if checkLabel() { disMissLabel() }
        } else {
            if checkMilestone() { disMissMilestone() }
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
