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
    case EditLabel
    case EditMilestone
}

protocol PopupLabelViewControllerDelegate: class {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.LabelItem)
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.LabelItem)
}

protocol PopupMilestoneViewControllerDelegate: class {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.MilestoneItem)
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.MilestoneItem)
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
    var router: (PopUpDataPassing)?
    weak var labelDelegate: PopupLabelViewControllerDelegate?
    weak var milestoneDelegate: PopupMilestoneViewControllerDelegate?
        
    // MARK:- View LifeCycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMode()
    }
    
    // MARK:- Setup by Mode
    private func setup() {
        contentSizeInPopup = CGSize(width: 300, height: 280)
        landscapeContentSizeInPopup = CGSize(width: 300, height: 200)
        let viewController = self
        let router = PopUpRouter()
        viewController.router = router
        router.viewController = viewController
    }
    
    private func setupMode() {
        if mode == .Label || mode == .EditLabel { setupLabelMode() }
        else { setupMilestoneMode() }
    }
    
    private func setupLabelMode() {
        totalLabel[2].text = "색상"
        descriptionTextField.isHidden = true
        
        if mode == .EditLabel {
            titleTextField.text = router?.editLabelData.first?.name
            detailTestField.text = router?.editLabelData.first?.description
            labelColorField.text = router?.editLabelData.first?.color
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
            titleTextField.text = router?.editMilestoneData.first?.title
            detailTestField.text = FormattedEditDateString(dueDate: (router?.editMilestoneData.first?.dueDate)!)
            descriptionTextField.text = router?.editMilestoneData.first?.content
        }
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
        if mode == .Label || mode == .EditLabel {
            let newLabel = PopupItem.LabelItem(
                title: titleTextField.text!,
                description: descriptionTextField.text ?? nil,
                color: labelColorField.text!
            )
            if mode == .Label {
                labelDelegate?.popupViewController(self, didFinishAdding: newLabel)
            } else {
                labelDelegate?.popupViewController(self, didFinishEditing: newLabel)
            }
        } else {
            let newLabel = PopupItem.MilestoneItem(
                title: titleTextField.text!,
                dueDate:detailTestField.text!,
                content: descriptionTextField.text!
            )
            if mode == .Milestone {
                milestoneDelegate?.popupViewController(self, didFinishAdding: newLabel)
            } else {
                milestoneDelegate?.popupViewController(self, didFinishEditing: newLabel)
            }
        }
        self.dismiss(animated: true, completion: nil)
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
