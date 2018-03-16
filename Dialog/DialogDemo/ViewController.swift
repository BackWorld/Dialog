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
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = .right
		let attributes = [
			NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),
			NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: UIColor.black
		]
        Dialog.default(title: NSAttributedString(string: "Title"),
					   message: NSAttributedString(string: "Message")
			, actions: [
						Dialog.Action(title: NSAttributedString(string: "hello1"), icon: UIImage(named: "icon"), handler: nil),
            Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
		])
	}
	
	@IBAction func dialogImage(_ sender: Any) {
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = .left
		let attributes = [
			NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),
			NSParagraphStyleAttributeName: paragraph,
			NSForegroundColorAttributeName: UIColor.black
		]
		Dialog.image(UIImage(named: "image"), actions: [
			Dialog.Action(title: NSAttributedString(string: "hello1", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			Dialog.Action(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
		])
	}
	
	@IBAction func dialogCustom(_ sender: Any) {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActionCollectionVC") as! ActionCollectionVC
		vc.view.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 100))
		vc.collectionView?.delegate = self
		
		Dialog.custom(vc.view, actions: [
			Dialog.Action(title: NSAttributedString(string: "Cancel"))
		])
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}

}

extension ViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("You clicked Action Item \(indexPath.item)")
		
		Dialog.default(title: NSAttributedString(string: "You clicked Action Item \(indexPath.item)"), actions: [
			Dialog.Action(title: NSAttributedString(string: "Ok"))
		])
	}
}

