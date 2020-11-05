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
    func displayAlert(viewModel: ListLabels.CreateLabel.ViewModel)
    func displayAlert(viewModel: ListLabels.EditLabel.ViewModel)
    func displayAlert(viewModel: ListLabels.DeleteLabel.ViewModel)
}

class LabelListViewController: UIViewController {
    
    private var interactor: LabelListBusinessLogic?
    private var displayedLabels: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
    let identifier = "labelCell"
    
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    // MARK:- Object Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                deleteLabel(at: indexPath)
                completion(true)
            }
            delete.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [delete])
        }

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        labelCollectionView.collectionViewLayout = layout
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func deleteLabel(at indexPath: IndexPath) {
        let labelId = displayedLabels[indexPath.item].id
        interactor?.deleteLabel(request: ListLabels.DeleteLabel.Request(id: labelId))
    }
    
    // MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateLabelPopup" {
            let destinationVC = segue.destination as! PopUpViewController
            let popupController = STPopupController(rootViewController: destinationVC)
            destinationVC.mode = .CreateLabel
            destinationVC.labelDelegate = self
            popupController.present(in: self)
        } else if segue.identifier == "EditLabelPopup" {
            let destinationVC = segue.destination as! PopUpViewController
            let popupController = STPopupController(rootViewController: destinationVC)
            let cell = sender as! LabelCollectionViewCell
            let indexPath: IndexPath = labelCollectionView.indexPath(for: cell)!
            destinationVC.mode = .EditLabel
            destinationVC.labelDelegate = self
            destinationVC.displayedLabel = displayedLabels[indexPath.item]
            popupController.present(in: self)
        }
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
        interactor?.fetchLabels(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListLabels.FetchLists.ViewModel) {
        displayedLabels = viewModel.displayedLabels
        labelCollectionView.reloadData()
    }
    
    func displayAlert(viewModel: ListLabels.CreateLabel.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.fetchLabels()
        }))
        present(alert, animated: true)
    }
    
    func displayAlert(viewModel: ListLabels.EditLabel.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.fetchLabels()
        }))
        present(alert, animated: true)
    }
    
    func displayAlert(viewModel: ListLabels.DeleteLabel.ViewModel) {
        let displayedAlert = viewModel.displayedAlert
        let alert = UIAlertController(
            title: displayedAlert.title,
            message: displayedAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.fetchLabels()
        }))
        present(alert, animated: true)
    }
}

extension LabelListViewController: PopupLabelViewControllerDelegate {
    
    func popupViewController(_ controller: PopUpViewController, didFinishAdding item: PopupItem.LabelItem) {
        let newLabel = ListLabels.CreateLabel.Request(
            newLabel: PostLabel(
                name: item.title,
                color: item.color,
                description: item.description
            )
        )
        interactor?.createNewLabel(request: newLabel)
    }
    
    func popupViewController(_ controller: PopUpViewController, didFinishEditing item: PopupItem.EditLabelItem) {
        let editLabel = ListLabels.EditLabel.Request(
            id: item.id,
            editLabel: PostLabel(
                name: item.title,
                color: item.color,
                description: item.description
            )
        )
        interactor?.editLabel(request: editLabel)
    }
    
}

extension LabelListViewController: UICollectionViewDelegate { }





