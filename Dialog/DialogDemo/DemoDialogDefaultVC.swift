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

    }

	@IBAction func cornerRadius(_ sender: UISlider) {
		configuration.cornerRadius = Int(sender.value)
		cornerRadiusLb.text = "cornerRadius(0~20): \(configuration.cornerRadius)"
	}
	
	@IBAction func isBackgroundViewUserInteractionEnabled(_ sender: UISwitch) {
		configuration.isBackgroundViewUserInteractionEnabled = sender.isOn
	}
	
	@IBAction func primaryColor(_ sender: UISegmentedControl) {
		let color: UIColor = sender.selectedSegmentIndex == 0 ? .black : .red
		configuration.primaryColor = color
	}
	
	@IBAction func showDialog(_ sender: Any) {
		Dialog.default(title: dtitle, message: message, actions: [action], configuration: configuration)
	}
	
}

extension DemoDialogDefaultVC: UITextFieldDelegate{
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		switch textField {
		case titleTF:
			dtitle.text = textField.text
		case messageTF:
			message.text = textField.text
		case actionTF:
			action.title = textField.text
		default: break
		}
		return true
	}
}
