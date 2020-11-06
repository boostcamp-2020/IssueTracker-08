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
    func displayAlert(viewModel: CreateMilestones.CreateMilestone.ViewModel)
    func displayAlert(viewModel: CreateMilestones.EditMilestone.ViewModel)
    func displayAlert(viewModel: DeleteMilestones.DeleteMilestone.ViewModel)
}

class MilestoneViewController: UIViewController {
    private var interactor: MilestoneListBusinessLogic?
    private var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
    private let reuseIdentifier = "milestoneCell"
    
    @IBOutlet weak var milestoneCollectionView: UICollectionView!
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
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                handleSwipe(for: action, path: indexPath)
                completion(true)
            }
            delete.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [delete])
        }

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        milestoneCollectionView.collectionViewLayout = layout
        milestoneCollectionView.delegate = self
        milestoneCollectionView.dataSource = self
        milestoneCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
            destinationVC.mode = .CreateMilestone
        } else {
            destinationVC.mode = .EditMilestone
            let cell = sender as! MilestoneCollectionViewCell
            let indexPaths = self.milestoneCollectionView.indexPath(for: cell)
            destinationVC.displayedMilestone = displayedMilestones[indexPaths!.item]
        }
        destinationVC.milestoneDelegate = self
        popupController.present(in: self)
    }
    
    func handleSwipe(for action: UIContextualAction, path: IndexPath) {
        let alert = UIAlertController(title: action.title,
                                    message: "정말로 삭제하시겠습니까?",
                                    preferredStyle: .alert)
            
        let okAction = UIAlertAction(title:"OK", style: .default, handler: { [self] (action) in
            let milestoneId = displayedMilestones[path.item].id
            interactor?.deleteMilestone(
                request: DeleteMilestones.DeleteMilestone.Request(
                    milestone: DeleteMilestones.MilestoneFormField(
                        milestoneId: milestoneId)
                )
            )
        })
        let cancleAction = UIAlertAction(title:"Cancle", style: .default, handler: { (_) in })
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion:nil)
    }
}

extension MilestoneViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMilestones.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

extension MilestoneViewController: MilestoneListDisplayLogic {
    func fetchMilestones() {
        let request = ListMilestones.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListMilestones.FetchLists.ViewModel) {
        displayedMilestones = viewModel.displayedMilestones
        milestoneCollectionView.reloadData()
    }
    
    func displayAlert(viewModel: CreateMilestones.CreateMilestone.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.fetchMilestones()
        }))
        present(alert, animated: true)
    }
    
    func displayAlert(viewModel: CreateMilestones.EditMilestone.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.fetchMilestones()
        }))
        present(alert, animated: true)
    }
    
    func displayAlert(viewModel: DeleteMilestones.DeleteMilestone.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.fetchMilestones()
        }))
        present(alert, animated: true)
    }
}

extension MilestoneViewController: PopupMilestoneViewControllerDelegate {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.MilestoneItem) {
        let newLabel = CreateMilestones.CreateMilestone.Request(
            milestone: CreateMilestones.MilestoneFormField(
                title: item.title,
                dueDate: item.dueDate,
                content: item.content
            )
        )
        interactor?.createNewMilestone(request: newLabel)
    }
    
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.EditMilestoneItem) {
        let newLabel = CreateMilestones.EditMilestone.Request(
            index: item.id,
            milestoneFormFileds: CreateMilestones.MilestoneFormField(
                title: item.title,
                dueDate: item.dueDate,
                content: item.content
            )
        )
        
        interactor?.editMilestone(request: newLabel)
    }
}

extension MilestoneViewController: UICollectionViewDelegate { }
