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
    
    private let cardHeight: CGFloat = 600
    private let cardHandleAreaHeight: CGFloat = 95
    
    // MARK:- Other Variable
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var issueTag: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var openStatus: [UIButton]!
    
    var interactor: IssueDetailBusinessLogic?
    var router: (IssueDetailDataReceiving)?
    var displayIssue: ListIssueDetail.FetchDetail.ViewModel?
    var displayComment: [comment] = []
    private var markdownView = MarkdownView()
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
        setupCard()
        setupCollectionview()
        tabbarSetup(AccessType: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchIssue()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabbarSetup(AccessType: false)
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
    
    
    func tabbarSetup(AccessType: Bool) {
        let tabberHeight = self.tabBarController!.tabBar.frame.height
        if AccessType {
            self.tabBarController!.tabBar.frame.origin.y = view.frame.height + tabberHeight
        } else {
            self.tabBarController!.tabBar.frame.origin.y = view.frame.height - tabberHeight
        }
    }
    
    private func viewSetup() {
        userIdLabel.text = displayIssue!.displayedDetail.name
        issueTag.text = "#\(displayIssue!.displayedDetail.issueId)"
        titleLabel.text = displayIssue!.displayedDetail.title
        if displayIssue!.displayedDetail.isOpen != 1 {
            openStatus[0].isHidden = true
            openStatus[1].isHidden = false
        }
    }
}

// MARK:- CardView

extension IssueDetailViewController {

    private func setupCard() {
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
        viewSetup()
        IssueDetailCollectionView.reloadData()
    }
    
    func displayComment(viewModel: ListComment.FetchDetail.ViewModel) {
        displayComment = viewModel.displayedComment
        IssueDetailCollectionView.reloadData()
    }
    
    private func fetchIssue() {
        let tag = router!.issueDetailData!
        let issueRequest = ListIssueDetail.FetchDetail.Request(issueId: tag)
        let commentRequest = ListComment.FetchDetail.Request(issueId: tag)
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
            cell.userID.text = displayIssue!.displayedDetail.name
            cell.timeDifference.text = FormattedDifferenceDateString(dueDate: displayIssue!.displayedDetail.createAt)
            cell.content.load(markdown: displayIssue!.displayedDetail.content)
        }
        else {
            let displayedComment = displayComment[indexPath.item - 1]
            cell.userID.text = displayedComment.name
            cell.timeDifference.text = FormattedDifferenceDateString(dueDate: displayedComment.createAt)
            cell.content.load(markdown: displayedComment.content)
        }
        
        if displayComment.count == indexPath.item {
            cell.content.onRendered = { [self] height in
                setupCollectionview()
                activityIndicator.stopAnimating()
                loadingView.isHidden = true
                activityView.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension IssueDetailViewController: UICollectionViewDelegate { }
