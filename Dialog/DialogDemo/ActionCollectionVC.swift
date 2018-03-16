//
//  ActionCollectionVC.swift
//  Sheeter
//
//  Created by zhuxuhong on 2018/3/15.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class ActionItemCell: UICollectionViewCell {
	@IBOutlet weak var iconIV: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
}

class ActionCollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionItemCell
		cell.titleLabel.text = "Item \(indexPath.item + 1)"
		
        return cell
    }


}
