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
	
	@IBAction func dialogDefault(_ sender: Any) {
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = .center
		let attributes = [
			NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),
			NSParagraphStyleAttributeName: paragraph
		]
		Dialog.default(title: nil, message: nil, actions: [
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil),
			DialogAction(title: "hello1", icon: nil, handler: nil)
		])
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let alert = UIAlertController(title: "Long Title", message: "Long Message", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "action1", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action2", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "action3", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}

}

