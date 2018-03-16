//
//  DialogCustom.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

class DialogCustom: DialogViewController {
	fileprivate var customView: UIView!
	
	override var informationView: UIView?{
		return customView
	}
	
	override var calculatedInformationHeight: CGFloat{
		return customView.bounds.height
	}
	
	override class var nibViewController: DialogViewController?{
		return DialogTool.nibs.last as? DialogCustom
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }

	public static func show(customView: UIView!,
							actions: [Dialog.Action]?,
							configuration: Dialog.Configuration = .default)
	{
		if let vc = nibViewController as? DialogCustom {
			vc.configuration = configuration
			vc.actions = actions
			vc.customView = customView
				DialogTool.topViewControllerOfApplicationKeyWindow?.present(vc, animated: false, completion: nil)
			if let holder = DialogTool.holderViewController(for: customView) {
				vc.addChildViewController(holder)
			}
		}
	}
}
