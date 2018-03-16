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
        Dialog.default(title: NSAttributedString(string: "Title", attributes: attributes),
					   
					   message: NSAttributedString(string: "Message", attributes: attributes)
			, actions: [
						DialogAction(title: NSAttributedString(string: "hello1", attributes: attributes), icon: UIImage(named: "icon"), handler: nil),
            DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
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
			DialogAction(title: NSAttributedString(string: "hello1", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
			DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
		])
	}
	
	@IBAction func dialogCustom(_ sender: Any) {
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = .left
		let attributes = [
			NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),
			NSParagraphStyleAttributeName: paragraph,
			NSForegroundColorAttributeName: UIColor.black
		]
		Dialog.default(title: NSAttributedString(string: "Title", attributes: attributes),
					   message: NSAttributedString(string: "Message", attributes: attributes), actions: [
						DialogAction(title: NSAttributedString(string: "hello1", attributes: attributes), icon: nil, handler: nil),
						DialogAction(title: NSAttributedString(string: "hello2", attributes: attributes), icon: nil, handler: nil),
						])
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}

}

