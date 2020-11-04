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

class MilestoneViewController: UIViewController {
    private var interactor: MilestoneListBusinessLogic?
    private var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
    private let reuseIdentifier = "milestoneCell"
    var router: (MilestoneListDataPassing)?
    
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
        let router = MilestoneListRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.router = router
        router.viewController = viewController
    }
    
    func setupCollectionview() {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
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
            destinationVC.mode = .Milestone
            destinationVC.milestoneDelegate = self
            popupController.present(in: self)
        }
    }
    
    func handleSwipe(for action: UIContextualAction, path: IndexPath) {
        let alert = UIAlertController(title: action.title,
                                    message: "정말로 삭제하시겠습니까?",
                                    preferredStyle: .alert)
            
        let okAction = UIAlertAction(title:"OK", style: .default, handler: { [self] (action) in
            let issueId = displayedMilestones[path.item].id
            let request = DeleteMilestones.DeleteMilestone.Request(milestone: DeleteMilestones.MilestoneFormField(milestoneId: issueId))
            interactor?.deleteMilestone(request: request)
            
            let reRequest = ListMilestones.FetchLists.Request()
            interactor?.fetchIssues(request: reRequest)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "reuseNewAdd") as! PopUpViewController
        pushVC.mode = .EditMilestone
        
        router?.editMilestoneData.removeAll()
        router?.editMilestoneData.append(displayedMilestones[indexPath.item])
        router?.routeToNewAdd(pushVC: pushVC)
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
}

extension MilestoneViewController: PopupMilestoneViewControllerDelegate {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.MilestoneItem) {
        let request = CreateMilestones.CreateMilestone.Request.init(milestone:  CreateMilestones.MilestoneFormField(title: item.title, dueDate: item.dueDate, content: item.content))
        interactor?.createMilestone(request: request)
        
        let reRequest = ListMilestones.FetchLists.Request()
        interactor?.fetchIssues(request: reRequest)
    }
    
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.MilestoneItem) {
        // router로 보냈으니 router로 보내렴
    }
}

extension MilestoneViewController: UICollectionViewDelegate { }
