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

class LabelViewController: UICollectionViewController {
    private var interactor: LabelListBusinessLogic?
    private var displayedLabels: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
    private let identifier = "labelCell"
    var router: (LabelListDataPassing)?
    
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
        let router = LabelListRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.router = router
        router.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLabels()
    }
    
    @IBAction func reuseNewButton(_ sender: Any) {
        router?.routeToNewAdd()
    }
}

extension LabelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1
        let sectionInsets = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: 5.0)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let widthPerItem = UIScreen.main.bounds.width - paddingSpace
        return CGSize(width: widthPerItem, height: widthPerItem * 0.18)
    }
}

extension LabelViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerLabel", for: indexPath)
        return headerView
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedLabels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToNewAdd()
    }
}

extension LabelViewController: LabelListDisplayLogic {
    func fetchLabels() {
        let request = ListLabels.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListLabels.FetchLists.ViewModel) {
        displayedLabels = viewModel.displayedLabels
        self.collectionView?.reloadData()
    }
}
