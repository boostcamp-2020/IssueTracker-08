//
//  CollectionViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/28.
//

import UIKit
import STPopup

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    @IBAction func test(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "view")
        let popupController = STPopupController(rootViewController: pushVC!)
        popupController.present(in: self)
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }
}
