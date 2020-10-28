//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/27.
//

import UIKit

class IssueListViewController: UIViewController {
    var presenter: IssueListPresenterDelegate?
    var interactor: IssueListBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.DidLoad()
    }
    
    init() {
        setup()
    }
    
    required init?(coder: NSCoder) {
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setup() {
        let viewController = self
        let interactor = IssueListInteractor()
        let presenter = IssueListPresenter()
        viewController.interactor = interactor
        //interactor.presenter = presenter
        //presenter.viewController = viewController
    }
}

extension IssueListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueListCollectionViewCell", for: indexPath) as? IssueListCollectionViewCell
        else { return IssueListCollectionViewCell() }
        
        return cell
    }
}
