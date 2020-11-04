//
//  MilestoneCollectionViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/30.
//

import UIKit
import STPopup

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
    
    func setupCollectionview() {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                completion(true)
            }
            delete.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [delete])
        }

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMilestones()
    }
    
    // MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PopUpViewController
        let popupController = STPopupController(rootViewController: destinationVC)
        if segue.identifier == "MilestonePopup" {
            destinationVC.mode = .Milestone
        } else {
            destinationVC.mode = .EditMilestone
        }
        destinationVC.milestoneDelegate = self
        popupController.present(in: self)
    }
}

extension MilestoneCollectionViewController {

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

extension MilestoneCollectionViewController: PopupMilestoneViewControllerDelegate {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.MilestoneItem) {
        let request = CreateMilestones.CreateMilestone.Request.init(milestone:  CreateMilestones.MilestoneFormField(title: item.title, dueDate: item.dueDate, content: item.content))
        interactor?.createMilestone(request: request)
    }
    
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.MilestoneItem) {
        print(2)
    }
    
}
