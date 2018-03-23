//
//  Tool.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/15.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

struct DialogTool {
	static let resourcePath = "Frameworks/Dialog.framework"
	
	static var nibs: [Any]{
		return Bundle.main.loadNibNamed("\(resourcePath)/Dialog", owner: nil, options: nil) ?? []
	}
	
	static func attributes(for text: NSAttributedString) -> [String: Any]{
		var range = NSMakeRange(0, text.string.characters.count)
		return text.attributes(at: 0, effectiveRange: &range)
	}
	
	static func holderViewController(for view: UIView) -> UIViewController? {
		weak var parentResponder: UIResponder? = view
		while parentResponder != nil {
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}
	
	static var topViewControllerOfApplicationKeyWindow: UIViewController? {
		var vc = topViewController(of: UIApplication.shared.keyWindow?.rootViewController)
		while vc?.presentedViewController != nil {
			vc = topViewController(of: vc?.presentedViewController)
		}
		return topViewController(of: vc)
	}
	
	static func topViewController(of parentViewController: UIViewController?) -> UIViewController?{
		if let nav = parentViewController as? UINavigationController {
			return nav
		}
		if let tab = parentViewController as? UITabBarController {
			return tab
		}
		return parentViewController
	}
}
