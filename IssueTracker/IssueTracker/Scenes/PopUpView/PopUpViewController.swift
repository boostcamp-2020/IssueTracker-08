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
    @IBOutlet weak var dataPickerView: UIView!
    
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
        dataPickerView.isHidden = true
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
        datePicker()
        if mode == .EditMilestone {
            titleTextField.text = displayedMilestone?.title
            descriptionTextField.text = displayedMilestone?.content
        }
    }
    
    private func datePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.calendar = .current
        datePicker.tintColor = .black
    
        let timeData = datePicker.subviews[0].subviews[1].subviews[0] as! UILabel
        let dateData = datePicker.subviews[0].subviews[0].subviews[0] as! UILabel
        timeData.font = timeData.font.withSize(14)
        dateData.font = dateData.font.withSize(14)
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        if mode == .EditMilestone {
            
            if displayedMilestone?.dueDate == nil {
                datePicker.date = FormattedEditDate(dueDate: FormattedDateToString(dueDate: Date()) )
            }
            else { datePicker.date = FormattedEditDate(dueDate: (displayedMilestone?.dueDate)!) }
        }
        datePicker.subviews[0].subviews[0].backgroundColor = .white
        datePicker.subviews[0].subviews[1].backgroundColor = .white
        
        dataPickerView.addSubview(datePicker)
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
        let pickerDate = dataPickerView.subviews[0] as! UIDatePicker
        let dueDate = FormattedDateToString(dueDate: pickerDate.date)
        
        if mode == .CreateMilestone {
            let newLabel = PopupItem.MilestoneItem(
                title: titleTextField.text!,
                dueDate: dueDate,
                content: descriptionTextField.text!
            )
            milestoneDelegate?.popupViewController(self, didFinishAdding: newLabel)
        } else {
            let newLabel = PopupItem.EditMilestoneItem(
                id: displayedMilestone!.id,
                title: titleTextField.text!,
                dueDate: dueDate,
                content: descriptionTextField.text!
            )
            milestoneDelegate?.popupViewController(self, didFinishEditing: newLabel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkLabel() -> Bool {
        // 값 비어있으면 false
        if titleTextField.text!.isEmpty || labelColorField.text!.isEmpty {
            warningAlert()
            return false
        }
        // 올바른 color 값이 아니면 false
        else if !colorTextCheck(colorText: labelColorField.text!) {
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
    
    private func colorTextCheck(colorText: String) -> Bool{
        if colorText.count != 6 {
            return false
        }
        else if colorText != UIColor(hexString: colorText).toHexString() {
            return false
        }
        
        return true
    }
    
    private func warningAlert() {
        let alert = UIAlertController(title: "경고",
                                    message: "다시 확인해주세요.",
                                    preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title:"Cancel", style: .default, handler: { (_) in })
        alert.addAction(cancleAction)
        present(alert, animated: true, completion:nil)
    }
    
    //MARK:- OBJC
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        datePicker.subviews[0].subviews[0].backgroundColor = .white
        datePicker.subviews[0].subviews[1].backgroundColor = .white
    }
    
    //MARK:- IBActions
    @IBAction func btnClickReload(_ sender: Any) {
        let reloadColor = randomColor()
        colorPickerButton.backgroundColor = reloadColor
        descriptionTextField.isHidden = true
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
        descriptionTextField.isHidden = true
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
            if mode == .CreateLabel || mode == .EditLabel {
                labelColorField.becomeFirstResponder()
            } else {
                descriptionTextField.becomeFirstResponder()
            }
        }
        return true
    }
    
    private func changeBtnColor(colorText: String) {
        if !colorTextCheck(colorText: colorText) {
            descriptionTextField.layer.borderColor = UIColor.red.cgColor
            descriptionTextField.layer.borderWidth = 1
            descriptionTextField.isHidden = false
            colorPickerButton.backgroundColor = UIColor.white
        } else {
            descriptionTextField.isHidden = true
            colorPickerButton.backgroundColor = UIColor(hexString: colorText)
        }
    }
}

