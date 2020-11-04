//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/30.
//

import UIKit
import STPopup

protocol LabelListDisplayLogic: class {
    func displayFetchedOrders(viewModel: ListLabels.FetchLists.ViewModel)
}

class LabelListViewController: UIViewController {
    
    private var interactor: LabelListBusinessLogic?
    private var displayedLabels: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
    let identifier = "labelCell"
    
    @IBOutlet weak var LabelCollectionView: UICollectionView!
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
        let interactor = LabelListInteractor()
        let presenter = LabelListPresenter()
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
        LabelCollectionView.collectionViewLayout = layout
        LabelCollectionView.delegate = self
        LabelCollectionView.dataSource = self
        LabelCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLabels()
    }
    
    // MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LabelPopup" {
            let destinationVC = segue.destination as! PopUpViewController
            let popupController = STPopupController(rootViewController: destinationVC)
            destinationVC.mode = .Label
            destinationVC.labelDelegate = self
            popupController.present(in: self)
        }
        // 해당 코드 마일스톤에서도 똑같이구현해주기
    }
}

extension LabelListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedLabels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? LabelCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupComponents()
        
        let displayedLabel = displayedLabels[indexPath.item]
        
        cell.titleLabel.setTitle(displayedLabel.name, for: .normal)
        cell.configureLabelButton(label: cell.titleLabel, hexString: displayedLabel.color)
        cell.descriptionLabel.text = displayedLabel.description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // did select item at
    }
}

extension LabelListViewController: LabelListDisplayLogic {
    func fetchLabels() {
        let request = ListLabels.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListLabels.FetchLists.ViewModel) {
        displayedLabels = viewModel.displayedLabels
        LabelCollectionView.reloadData()
    }
}

extension LabelListViewController: PopupLabelViewControllerDelegate {
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.LabelItem) {
        
    }
    
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.LabelItem) {
        
    }
}

extension LabelListViewController: UICollectionViewDelegate { }
