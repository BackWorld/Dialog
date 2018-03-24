//
//  ViewController.swift
//  DialogDemo
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit
import Dialog

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	@IBAction func dialogImage(_ sender: Any) {
		Dialog.image(UIImage(named: "image"), actions: [
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1")
		])
	}
	
	@IBAction func dialogCustom(_ sender: Any) {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActionCollectionVC") as! ActionCollectionVC
		vc.view.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 100))
		vc.collectionView?.delegate = self

		Dialog.custom(vc.view, actions: [
            Dialog.Action(title: "Cancel", style: .cancel)
		])
	}
}

extension ViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Dialog.default(title: .init("You clicked Action Item \(indexPath.item)"), actions: [
            Dialog.Action(title: "Ok")
        ])
	}
}

