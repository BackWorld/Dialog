//
//  DemoDialogDefaultVC.swift
//  DialogDemo
//
//  Created by zhuxuhong on 2018/3/21.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit
import Dialog

class DemoDialogDefaultVC: UITableViewController {
	@IBOutlet weak var titleTF: UITextField!
	@IBOutlet weak var messageTF: UITextField!
	@IBOutlet weak var actionTF: UITextField!
	@IBOutlet weak var cornerRadiusLb: UILabel!
	
	let configuration = Dialog.Configuration()
	let dtitle = Dialog.Title()
	let message = Dialog.Message()
	let action = Dialog.Action()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		dtitle.text = titleTF.text
		message.text = messageTF.text
		action.title = actionTF.text
		
		NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }

	@IBAction func cornerRadius(_ sender: UISlider) {
		configuration.cornerRadius = Int(sender.value)
		cornerRadiusLb.text = "cornerRadius(0~20): \(configuration.cornerRadius)"
	}
	
	@IBAction func isBackgroundViewUserInteractionEnabled(_ sender: UISwitch) {
		configuration.isBackgroundViewUserInteractionEnabled = sender.isOn
	}
	
	@IBAction func titleColor(_ sender: UISegmentedControl) {
		let color: UIColor = sender.selectedSegmentIndex == 0 ? .black : .green
		dtitle.color = color
	}
	
	@IBAction func titleAlignment(_ sender: UISegmentedControl) {
		let index = sender.selectedSegmentIndex
		let aligment = NSTextAlignment(rawValue: index)!
		dtitle.alignment = aligment
	}
	
	lazy var actions: [Dialog.Action] = [self.action]
	
	@IBAction func actions(_ sender: UISegmentedControl) {
		let index = sender.selectedSegmentIndex
		 actions = (0..<index).map{i in
			let action = Dialog.Action(title: "\(self.action.title ?? "Action") \(i+1)", icon: self.action.icon, style: self.action.style, handler: nil)
			return action
		}
		actions.insert(action, at: 0)
	}
	
	@IBAction func actionIcon(_ sender: UISwitch) {
		action.icon = sender.isOn ? UIImage(named: "icon") : nil
	}
	
	@IBAction func actionStyle(_ sender: UISegmentedControl) {
		let index = sender.selectedSegmentIndex
		switch index {
		case 0:
			action.style = .default
		case 1:
			action.style = .cancel
		case 2:
			action.style = .destructive
		default: break
		}
	}
	
	@IBAction func actionStyleColor(_ sender: UISegmentedControl) {
		let color: UIColor = sender.selectedSegmentIndex == 0 ? .black : .orange
		action.style.tintColor = color
	}
	
	@IBAction func actionStyleAlignment(_ sender: UISegmentedControl) {
		let index = sender.selectedSegmentIndex
		let aligment = UIControlContentHorizontalAlignment(rawValue: index)!
		action.style.alignment = aligment
	}
	
	@IBAction func actionStyleIsBold(_ sender: UISwitch) {
		action.style.isBold = sender.isOn
	}
	
	@IBAction func showDialog(_ sender: Any) {
		Dialog.default(title: dtitle, message: message, actions: actions, configuration: configuration)
	}
	
}

extension DemoDialogDefaultVC{
	func textFieldDidChange(_ sender: Notification){
		let textField = sender.object as! UITextField
		switch textField {
		case titleTF:
			dtitle.text = textField.text
		case messageTF:
			message.text = textField.text
		case actionTF:
			action.title = textField.text
		default: break
		}
	}
}
