//
//  IssueEnrollViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/08.
//
import UIKit
import MarkdownView
import SafariServices

enum EnrollMode {
    case CreateIssue
    case EditIssue
    case CreateComment
    case EditComment
}

protocol IssueEnrollDisplayLogic: class {
    func displayAlert(viewModel: issueEnrolls.CreateIssue.ViewModel)
    func displayEditAlert(viewModel:issueEnrolls.EditIssue.ViewModel)
    func displayCommentAlert(viewModel: issueComment.CreateComment.ViewModel)
    func displayEditCommentAlert(viewModel: issueComment.EditIssue.ViewModel)
    func displayDeleteCommentAlert(viewModel: issueComment.DeleteIssue.ViewModel)
}

class IssueEnrollViewController: UIViewController {
    
    // MARK:- IBOutelts
    
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var markdownSegment: UISegmentedControl!
    @IBOutlet weak var markdownUIView: UIView!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    // MARK:- Properties
    var mode: EnrollMode = .CreateIssue
    private var markdown = ["Markdown", "Preview"]
    private let markdownView = MarkdownView()
    private let menuController = UIMenuController.shared
    private let imagePicker = UIImagePickerController()
    var interactor: IssueEnrollBusinessLogic?
    var router: (IssueEnrollDataReceiving)?
    var commentId: Int?
    var issueEditData: DetailRouteData?
    @IBOutlet weak var commentDeleteBtn: UIButton!
    
    // MARK:- View Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        editSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        editSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK:- IBActions
    @IBAction func saveButton(_ sender: Any) {
        if mode == .CreateIssue {
            createIssue()
        }
        else if mode == .EditIssue {
            editIssue()
        }
        else if mode == .CreateComment {
            createComment()
        }
        else {
            editComment()
        }
    }
    
    @IBAction func commentDeleteClick(_ sender: Any) {
        let request = issueComment.DeleteIssue.Request(
            commentId: commentDeleteData(
                commentId: commentId!
            )
        )
        interactor?.deleteComment(request: request)
    }
    
    private func createIssue() {
        let request = issueEnrolls.CreateIssue.Request(
            newIssue: issueEnrollData(
                userId: UserDefaults.standard.object(forKey: "ID") as! Int,

                title: titleTextField.text!,
                content: textDescription.text
            ),
            token: UserDefaults.standard.object(forKey: "JWT") as! String
        )
        interactor?.createNewIssue(request: request)
    }
    
    private func editIssue() {
        let request = issueEnrolls.EditIssue.Request(
            editIssue: issueEnrollData(
                userId: UserDefaults.standard.object(forKey: "ID") as! Int,
                title: titleTextField.text!,
                content: textDescription.text
            ),
            issueId: (router?.issueEditData!.id)!
            ,
            token: UserDefaults.standard.object(forKey: "JWT") as! String
        )
        interactor?.editIssue(request: request)
    }
    
    private func createComment() {
        let request = issueComment.CreateComment.Request(
            comment: commentData(
                userId: UserDefaults.standard.object(forKey: "ID") as! Int,
                issueId: (router?.issueEditData!.id)!,
                content: textDescription.text
            )
        )
        interactor?.createNewComment(request: request)
    }
    
    private func editComment() {
        let request = issueComment.EditIssue.Request(
            editComment: commentEditData(
                userId: UserDefaults.standard.object(forKey: "ID") as! Int,
                issueId: issueEditData!.id,
                content: textDescription.text,
                commentId: commentId!
            )
        )
        interactor?.editComment(request: request)
    }
}

// MARK:- Setup
extension IssueEnrollViewController {
    
    private func setup() {
        titleView.layer.addBorder([.top, .bottom], color: UIColor.systemGray5, width: 1)
        textDescription.layer.borderWidth = 1
        textDescription.layer.borderColor = UIColor.systemGray.cgColor
        setupPlaceholder()
        setupMenuController()
        setupImagePicker()
        addMarkdownConstraints()
        addObservers()
        if mode == .EditIssue {
            issueTitle.text = "Edit Issue"
            titleTextField.text = router?.issueEditData?.title
            textDescription.text = router?.issueEditData?.content
            textDescription.textColor = UIColor.black
        }
        else if mode == .CreateComment {
            issueTitle.text = "New Comment"
            titleTextField.text = router?.issueEditData?.title
            titleTextField.isUserInteractionEnabled = false
        }
        else if mode == .EditComment {
            titleTextField.text = issueEditData?.title
            titleTextField.isUserInteractionEnabled = false
            textDescription.text = issueEditData?.content
            textDescription.textColor = UIColor.black
            issueTitle.text = "Edit Comment"
            commentDeleteBtn.isHidden = false
        }
    }
    
    private func editSetup() {
        let viewController = self
        let interactor = IssueEnrollInteractor()
        let presenter = IssueEnrollPresenter()
        let router = IssueEnrollRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addMarkdownConstraints() {
        markdownUIView.addSubview(markdownView)
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        markdownView.topAnchor.constraint(equalTo: markdownUIView.topAnchor).isActive = true
        markdownView.leadingAnchor.constraint(equalTo: markdownUIView.leadingAnchor).isActive = true
        markdownView.trailingAnchor.constraint(equalTo: markdownUIView.trailingAnchor).isActive = true
        markdownView.bottomAnchor.constraint(equalTo: markdownUIView.bottomAnchor).isActive = true
        
        markdownSegment.addTarget(self, action: #selector(updateView), for: .valueChanged)
    }
    
    private func setupMenuController() {
        menuController.showMenu(from: view, rect: CGRect.zero)
        menuController.arrowDirection = UIMenuController.ArrowDirection.default
        let menuItem1: UIMenuItem = UIMenuItem(title: "Insert Photo", action: #selector(menuInsertPhoto(sender:)))
        menuController.menuItems = [menuItem1]
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
    }
    
}

// MARK:- Selector @objc
extension IssueEnrollViewController {
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        let tabbarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        if textDescription.isFirstResponder {
            view.frame.origin.y = -145
            textViewBottomConstraint.constant = (keyboardHeight - tabbarHeight) - 145 + 14
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        textViewBottomConstraint.constant = 14
    }
    
    @objc func updateView() {
        let selectedSeg = markdown[markdownSegment.selectedSegmentIndex]
        if selectedSeg == "Markdown" {
            markdownUIView.isHidden = true
            textDescription.isHidden = false
        } else {
            markdownUIView.isHidden = false
            textDescription.isHidden = true
            if markdownView.subviews.count > 0 {
                markdownView.subviews[0].removeFromSuperview()
            }
            if textDescription.textColor != UIColor.lightGray {
                markdownView.onTouchLink = { [weak self] request in
                  guard let url = request.url else { return false }
                  if url.scheme == "file" { return true }
                  else if url.scheme == "https" {
                    let safari = SFSafariViewController(url: url)
                    self?.present(safari, animated: true, completion: nil)
                    return false
                  }
                  else { return false }
                }
                markdownView.load(markdown: textDescription.text, enableImage: true)
            }
        }
    }
    
    @objc private func menuInsertPhoto(sender: UIMenuItem) {
        openPhotosLibrary()
    }
    
}

// MARK:- UITextViewDelegate
extension IssueEnrollViewController: UITextViewDelegate {
    
    private func setupPlaceholder() {
        textDescription.delegate = self
        textDescription.text = "코멘트는 여기에 작성하세요."
        textDescription.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textDescription.textColor == UIColor.lightGray {
            textDescription.text = nil
            textDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textDescription.text.isEmpty {
            textDescription.text = "코멘트는 여기에 작성하세요."
            textDescription.textColor = UIColor.lightGray
        }
    }
    
//    override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
//        let cut = #selector(cut(_:))
//        let copy = #selector(copy(_:))
//        let watnedActions = [cut, copy, #selector(menuInsertPhoto(sender:))]
//
//        if watnedActions.contains(action) { return true }
//        else { return false }
//    }
    
}

extension IssueEnrollViewController: UIImagePickerControllerDelegate,
                                     UINavigationControllerDelegate {
    func openPhotosLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // TODO:
            // Send to server and receive a link
            // 3가지 info key가 들어가 있는데 어떤 정보를 뽑아서 보낼지는 더 알아봐야 함
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            if textDescription.text.isEmpty { textDescription.text = imageURL.absoluteString }
            else { textDescription.text.append("\n\(imageURL)") }
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension IssueEnrollViewController: IssueEnrollDisplayLogic {
    
    func displayAlert(viewModel: issueEnrolls.CreateIssue.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func displayEditAlert(viewModel: issueEnrolls.EditIssue.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func displayCommentAlert(viewModel: issueComment.CreateComment.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func displayEditCommentAlert(viewModel: issueComment.EditIssue.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func displayDeleteCommentAlert(viewModel: issueComment.DeleteIssue.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
}
