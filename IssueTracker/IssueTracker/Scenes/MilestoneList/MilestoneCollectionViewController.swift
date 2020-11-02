//
//  MilestoneCollectionViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/30.
//

import UIKit

protocol MilestoneListDisplayLogic: class {
    func displayFetchedOrders(viewModel: ListMilestones.FetchLists.ViewModel)
}

class MilestoneCollectionViewController: UICollectionViewController {
    private var interactor: MilestoneListBusinessLogic?
    private var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
    private let reuseIdentifier = "milestoneCell"
    
    // MARK:- Object Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK:- Setup
    private func setup() {
        let viewController = self
        let interactor = MilestoneListInteractor()
        let presenter = MilestoneListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMilestones()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "milestoneheader", for: indexPath)
        return headerView
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMilestones.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MilestoneCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupComponents()
        
        let displayedMilestone = displayedMilestones[indexPath.item]
        
        cell.titleLabel.setTitle(displayedMilestone.title, for: .normal)
        cell.descriptionLabel.text = displayedMilestone.content
        cell.dateLabel.text = displayedMilestone.dueDate
        
        return cell
    }
}

extension MilestoneCollectionViewController: MilestoneListDisplayLogic {
    func fetchMilestones() {
        let request = ListMilestones.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListMilestones.FetchLists.ViewModel) {
        displayedMilestones = viewModel.displayedMilestones
        self.collectionView?.reloadData()
    }
}

extension MilestoneCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1
        let sectionInsets = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: 5.0)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let widthPerItem = UIScreen.main.bounds.width - paddingSpace
        return CGSize(width: widthPerItem, height: widthPerItem * 0.25)
    }
}
