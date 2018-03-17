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
		
//		Dialog.Configuration.default.isBackgroundViewUserInteractionEnabled = true
//		Dialog.Configuration.default.cornerRadius = 10
    }
	
	@IBAction func dialogDefault(_ sender: Any) {
//        Dialog.Configuration.default.primaryColor = .orange
        
        Dialog.default(title: .init("标题"),
                       message: .init("消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息"),
                       actions:
            [
                Dialog.Action(title: "Default"),
                Dialog.Action(title: "Cancel", style: .cancel),
                Dialog.Action(title: "Destructive", style: .destructive),
                Dialog.Action(title: "Custom", style: .custom(tintColor: .green, alignment: .right, isPrimary: true)),
            ]
        )
	}
	
	@IBAction func dialogImage(_ sender: Any) {
		Dialog.image(UIImage(named: "image"), actions: [
			Dialog.Action(title: "hello1")
		])
	}
	
	@IBAction func dialogCustom(_ sender: Any) {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActionCollectionVC") as! ActionCollectionVC
		vc.view.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 100))
		vc.collectionView?.delegate = self
		
		Dialog.custom(vc.view, actions: [
			Dialog.Action(title: "Cancel")
		])
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let alert = UIAlertController(title: "Title", message: "Message"  , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
	}

}

extension ViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Dialog.default(title: .init("You clicked Action Item \(indexPath.item)"), actions: [
            Dialog.Action(title: "Ok")
        ])
	}
}

