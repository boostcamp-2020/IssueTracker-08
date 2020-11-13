//
//  CardViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import UIKit

protocol MilestoneDetailDisplayLogic: class {
    func displayFetchedMilestone(viewModel: milestoneDetail.FetchLists.ViewModel)
}

class CardViewController: UIViewController {
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var splintProgress: UIProgressView!
    @IBOutlet weak var managerView: UIScrollView!
    @IBOutlet weak var managerHorizenStackView: UIStackView!
    @IBOutlet weak var LabelView: UIScrollView!
    @IBOutlet weak var LabelHorizenStackView: UIStackView!
    @IBOutlet weak var ManagerButton: UIButton!
    @IBOutlet weak var milestoneTitle: UILabel!
    @IBOutlet weak var issueStatusBtn: UIButton!
    
    var isOpen: Bool = false
    var issueId: Int = 0
    var displayedData: bottomModel?
    private var interactor: MilestoneDetailBusinessLogic?
    private var issueIntractor: IssueListBusinessLogic?
    var router: (IssueDetailDataReceiving & IssueDetailRoutingLogic)?
    
    // MARK:- Object Lifecycle
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
        let issueInteractor = IssueListInteractor()
        let interactor = CardViewDetailInteractor()
        let presenter = CardViewPresenter()
        let issuePresenter = IssueListPresenter()
        let router = IssueDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.issueIntractor = issueInteractor
        interactor.presenter = presenter
        presenter.viewController = viewController
        issueInteractor.presenter = issuePresenter
        router.cardViewController = viewController
    }
    
    func openCloseStatus(type: Bool) {
        issueStatusBtn.backgroundColor = UIColor.green
        issueStatusBtn.setTitle("Open Issue", for: .normal)
        isOpen = true
    }
    
    // MARK:- Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        splintProgress.transform = CGAffineTransform(scaleX: 1, y: 2)
        let tabberHeight = self.tabBarController!.tabBar.frame.height
        self.tabBarController!.tabBar.frame.origin.y = view.frame.height + tabberHeight
    }
    
    func setup(tag: Int, displayData: bottomModel) {
        displayedData = displayData
        issueId = tag
        print(displayData)
        if displayData.assign?.count != 0 {
            for view in managerHorizenStackView.subviews {
                view.removeFromSuperview()
            }
            displayData.assign?.forEach {
                managerSetup(name: $0.name, imageUrl: $0.imageUrl)
            }
        }
        if displayData.label?.count != 0 {
            for view in LabelHorizenStackView.subviews {
                view.removeFromSuperview()
            }
            displayData.label?.forEach {
                labelSetup(title: $0.labelName, labelColor: $0.labelColor)
            }
        }
        if displayData.MilestoneId != nil {
            fetchMilestone(id: displayData.MilestoneId!)
        } else {
            milestoneTitle.text = "Select Milestone"
            splintProgress.setProgress(0.0, animated: true)
        }
    }
    
    private func managerSetup(name: String, imageUrl: String) {
        let stackView = UIStackView()
        stackView.alignment = UIStackView.Alignment.center
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 5
        
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.layer.cornerRadius = 10
        
        let url = URL(string: imageUrl)
        let data = try! Data(contentsOf: url!)
        imageView.image = UIImage(data: data)
        imageView.layer.cornerRadius = 10
        
        let idLabel = UILabel()
        idLabel.text = name
        idLabel.textAlignment = .center
        idLabel.font = UIFont(name: "System", size: 6)
        idLabel.textColor = UIColor.darkGray
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(idLabel)
        
        managerHorizenStackView.addArrangedSubview(stackView)
        managerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func labelSetup(title: String, labelColor: String) {
        let label = UIButton()
        let backgroundUIColor = UIColor(hexString: labelColor)
        label.layer.cornerRadius = 5
        label.setTitle(title, for: .normal)
        label.backgroundColor = backgroundUIColor
        label.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        let luminance = backgroundUIColor.redValue * 0.299 + backgroundUIColor.greenValue * 0.587 + backgroundUIColor.blueValue * 0.114
        
        if luminance < 0.5 { label.setTitleColor(.white, for: .normal) }
        else { label.setTitleColor(.black, for: .normal) }
        
        LabelHorizenStackView.addArrangedSubview(label)
        LabelView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func managerEdit(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetDemoViewController") as! BottomTableViewController
        pushVC.mode = .UserMode
        pushVC.displayedData = displayedData
        self.present(pushVC, animated: true, completion: nil)
    }
    
    @IBAction func labelEdit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetDemoViewController") as! BottomTableViewController
        pushVC.mode = .LabelMode
        pushVC.displayedData = displayedData
        self.present(pushVC, animated: true, completion: nil)
    }
    
    @IBAction func MilestoneEdit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetDemoViewController") as! BottomTableViewController
        pushVC.mode = .MilestoneMode
        pushVC.displayedData = displayedData
        self.present(pushVC, animated: true, completion: nil)
    }
    
    @IBAction func clossIssueButton(_ sender: Any) {
        if !isOpen {
            issueIntractor?.closeIssue(
                request: ListIssues.CloseIssue.Request(
                    issueId: issueId
                )
            )
        } else {
            // 받아와서 수정
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentAddBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = storyboard.instantiateViewController(withIdentifier: "issueEnroll") as! IssueEnrollViewController
        pushVC.mode = .CreateComment
        router?.issueEditData = DetailRouteData(
            id: issueId,
            title: displayedData!.title,
            content: displayedData!.content
        )
        router?.routeToEnroll(destinationVC: pushVC)
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
}

extension CardViewController : MilestoneDetailDisplayLogic {
    func fetchMilestone(id: Int) {
        let request = milestoneDetail.FetchLists.Request(id: id)
        interactor?.fetchMilestone(request: request)
    }
    
    func displayFetchedMilestone(viewModel: milestoneDetail.FetchLists.ViewModel) {
        milestoneTitle.text = viewModel.displayedMilestones.title
        let allIssue = viewModel.displayedMilestones.closeIssue + viewModel.displayedMilestones.openIssue
        let percent = (Double(viewModel.displayedMilestones.closeIssue) / Double(allIssue))
        splintProgress.setProgress(Float(percent), animated: true)
    }
}
