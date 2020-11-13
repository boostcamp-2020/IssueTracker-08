//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import UIKit
import MarkdownView
import SafariServices

protocol IssueDetailDisplayLogic: class {
    func displayOpenIssue(viewModel: ListIssueDetail.FetchDetail.ViewModel)
    func displayComment(viewModel: ListComment.FetchDetail.ViewModel)
}

class IssueDetailViewController: UIViewController {
    // MARK:- CardView Variable
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardVisible = false
    var cardViewController: CardViewController!
    
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    private let cardHeight: CGFloat = 650
    private let cardHandleAreaHeight: CGFloat = 95
    
    // MARK:- Other Variable
    
    @IBOutlet weak var issueImage: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var issueTag: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var openStatus: [UIButton]!
    
    var issueId: Int = 0
    var markdownFlag: Bool = false
    var interactor: IssueDetailBusinessLogic?
    var router: (IssueDetailDataReceiving & IssueDetailRoutingLogic)?
    var displayIssue: ListIssueDetail.FetchDetail.ViewModel?
    var displayComment: [comment] = []
    
    @IBOutlet weak var IssueDetailCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityView: UIView!
    
    
    // MARK:- View Lifecycle
    
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
        setupCardView()
        setupCollectionview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        markdownFlag = false
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        activityView.isHidden = false
        fetchIssue()
        setupTabbar(AccessType: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setupTabbar(AccessType: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editComment" {
            let destinationVC = segue.destination as! IssueEnrollViewController
            let senderButton: UIButton = sender as! UIButton
            let indexpath: Int = Int(String(senderButton.restorationIdentifier!))!
           
            destinationVC.issueEditData = DetailRouteData(
                id: issueId,
                title: displayIssue!.displayedDetail.title,
                content: displayComment[indexpath].content
            )
            destinationVC.commentId = displayComment[indexpath].commentId
            destinationVC.mode = .EditComment
        }
    }
    
    private func markdownTouchAnction(markdown: MarkdownView) {
        markdown.onTouchLink = { [weak self] request in
          guard let url = request.url else { return false }

          if url.scheme == "file" {
            return true
          } else if url.scheme == "https" {
            let safari = SFSafariViewController(url: url)
            self?.present(safari, animated: true, completion: nil)
            return false
          } else {
            return false
          }
        }
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "issueEnroll") as! IssueEnrollViewController
        pushVC.mode = .EditIssue
        router?.issueEditData = DetailRouteData(
            id: issueId,
            title: displayIssue!.displayedDetail.title,
            content: displayIssue!.displayedDetail.content!
        )
        router?.routeToEnroll(destinationVC: pushVC)
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
}

// MARK:- Setup
extension IssueDetailViewController {
    
    func setup() {
        let viewController = self
        let interactor = IssueDetailInteractor()
        let presenter = IssueDetailPresenter()
        let router = IssueDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func setupCollectionview() {
        let layout: UICollectionViewCompositionalLayout = {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(300))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }()
        
        IssueDetailCollectionView.collectionViewLayout = layout
        IssueDetailCollectionView.delegate = self
        IssueDetailCollectionView.dataSource = self
    }
    
    
    func setupTabbar(AccessType: Bool) {
        let tabberHeight = self.tabBarController!.tabBar.frame.height
        if AccessType {
            self.tabBarController!.tabBar.frame.origin.y = view.frame.height + tabberHeight
        } else {
            self.tabBarController!.tabBar.frame.origin.y = view.frame.height - tabberHeight
        }
    }
    
    private func setupView() {
        userIdLabel.text = displayIssue!.displayedDetail.name
        issueTag.text = "#\(displayIssue!.displayedDetail.issueId)"
        titleLabel.text = displayIssue!.displayedDetail.title
        
        if displayIssue!.displayedDetail.isOpen != 1 {
            openStatus[0].isHidden = true
            openStatus[1].isHidden = false
            cardViewController.openCloseStatus(type: false)
        }
    }
    
    private func setupCardView() {
        cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)

        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IssueDetailViewController.handleCardTap(recognzier:)))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(IssueDetailViewController.handleCardPan(recognzier:)))
        
        self.cardViewController.view.layer.cornerRadius = 12
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
}

// MARK:- CardView
extension IssueDetailViewController {
    
    // MARK:- HandleAction
    
    @objc func handleCardTap(recognzier: UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCardPan(recognzier: UIPanGestureRecognizer) {
        switch recognzier.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognzier.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    // MARK:- AnimateTransition
    
    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion{ _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }
    
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}

// MARK:- Implement IssueDetailDisplayLogic

extension IssueDetailViewController: IssueDetailDisplayLogic {
    func displayOpenIssue(viewModel: ListIssueDetail.FetchDetail.ViewModel) {
        displayIssue = viewModel
        setupView()
        let cardViewData = bottomModel(
            title: displayIssue!.displayedDetail.title,
            content: displayIssue!.displayedDetail.content!,
            label: displayIssue!.displayedDetail.label,
            assign: displayIssue!.displayedDetail.assign,
            MilestoneId: displayIssue!.displayedDetail.milestoneId
        )
        cardViewController.setup(tag: issueId, displayData: cardViewData)
        if displayIssue!.displayedDetail.userId != UserDefaults.standard.object(forKey: "ID") as! Int {
            navigationItem.rightBarButtonItem = nil
        }
        
        IssueDetailCollectionView.reloadData()
    }
    
    func displayComment(viewModel: ListComment.FetchDetail.ViewModel) {
        displayComment = viewModel.displayedComment
        IssueDetailCollectionView.reloadData()
    }
    
    private func fetchIssue() {
        issueId = router!.issueDetailData!
        let issueRequest = ListIssueDetail.FetchDetail.Request(issueId: issueId)
        let commentRequest = ListComment.FetchDetail.Request(issueId: issueId)
        interactor?.fetchIssue(request: issueRequest)
        interactor?.fetchComment(request: commentRequest)
    }
}


// MARK:- Collection View

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayComment.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "detailCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        if displayIssue == nil { return cell }
        else if indexPath.item == 0  {
            if markdownFlag { return cell }
            cell.userID.text = displayIssue!.displayedDetail.name
            cell.timeDifference.text = FormattedDifferenceDateString(dueDate: displayIssue!.displayedDetail.createAt)
            markdownTouchAnction(markdown: cell.content)
            if cell.content.subviews.count > 0 {
                cell.content.subviews.forEach { $0.removeFromSuperview() }
            }
            let url = URL(string: displayIssue!.displayedDetail.imageUrl)
            let data = try! Data(contentsOf: url!)
            issueImage.image = UIImage(data: data)
            cell.userImage.image = UIImage(data: data)
            
            cell.content.load(markdown: displayIssue!.displayedDetail.content)
            cell.content.isScrollEnabled = false
            cell.editButton.isHidden = true
        }
        else {
            let userId = UserDefaults.standard.object(forKey: "ID")
            if userId as! Int != displayComment[indexPath.item - 1].userId {
                cell.editButton.isHidden = true
            }
            let displayedComment = displayComment[indexPath.item - 1]
            cell.userID.text = displayedComment.name
            cell.timeDifference.text = FormattedDifferenceDateString(dueDate: displayedComment.createAt)
            if cell.content.subviews.count > 0 {
                cell.content.subviews.forEach { $0.removeFromSuperview() }
            }
            let url = URL(string: displayedComment.imageUrl)
            let data = try! Data(contentsOf: url!)
            cell.userImage.image = UIImage(data: data)
            
            markdownTouchAnction(markdown: cell.content)
            cell.content.load(markdown: displayedComment.content)
            cell.content.isScrollEnabled = false
            cell.editButton.restorationIdentifier = "\(indexPath.item - 1)"
        }
        
        if displayComment.count == indexPath.item {
            cell.content.onRendered = { [self] height in
                setupCollectionview()
                activityIndicator.stopAnimating()
                loadingView.isHidden = true
                activityView.isHidden = true
                markdownFlag = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension IssueDetailViewController: UICollectionViewDelegate { }
