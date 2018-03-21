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
        
		func deleteDialog(){
			Dialog.default(title: .init("确定要删除该条评论?"), actions:[
				.init(title: "删除", style: .destructive, handler: {_ in
					
				}),
				.init(title: "取消")
			])
		}
		
		let configuration  = Dialog.Configuration()
		configuration.isBackgroundViewUserInteractionEnabled = true
		Dialog.default(actions: [
			.init(title: "删除", style: .destructive, handler: {
				_ in
				deleteDialog()
			}),
			.init(title: "分享"),
			.init(title: "举报"),
			.init(title: "屏蔽")
			], configuration: configuration)
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
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: {
			_ in
			let alert2 = UIAlertController(title: "Title2", message: "Message2"  , preferredStyle: .alert)
			alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
			self.present(alert2, animated: true, completion: nil)
		}))
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

