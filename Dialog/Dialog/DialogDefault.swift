//
//  DialogDefault.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

class DialogDefault: DialogViewController {
	fileprivate lazy var textView: UITextView = {
		let tv: UITextView = UITextView(frame: .zero)
		tv.font = UIFont.systemFont(ofSize: 16)
		tv.isEditable = false
		tv.isSelectable = false
		tv.isScrollEnabled = false
		return tv
	}()
	
	override class var nibViewController: DialogViewController?{
		return DialogTool.nibs.first as? DialogDefault
	}
	
	override var informationViewMargin: CGFloat{
		return 10
	}
	
	fileprivate var information: NSAttributedString!{
		didSet{
			textView.attributedText = information
			makeInformationView()
		}
	}
    
    override var calculatedInformationHeight: CGFloat{
		let margins = textView.layoutMargins
        let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let ratio: CGFloat = isPad ? 1/3 : (isLandscape ? 1/3 : 2/3)
        let width = (view.bounds.width * ratio) - 2 * informationViewMargin - margins.left - margins.right
        let size = CGSize(width: width, height: CGFloat.infinity)
        let height = information.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).height
        return height + margins.top + margins.bottom
    }
    
	override var informationView: UIView?{
		return textView
	}
	
	override func makeInformationView(){
		super.makeInformationView()
		
		guard !information.string.isEmpty else {
			informationWrapperViewHeightConstraint.constant = 0
			informationWrapperView.isHidden = true
			return
		}
	}
	
	fileprivate func attributedInformation(title: NSAttributedString?, message: NSAttributedString?) -> NSAttributedString{
		let attr = NSMutableAttributedString()
		if let title = title{
			attr.append(NSAttributedString(string: "\n"))
			attr.append(title)
			attr.append(NSAttributedString(string: "\n"))
		}
		if let message = message{
			attr.append(NSAttributedString(string: "\n"))
			attr.append(message)
			attr.append(NSAttributedString(string: "\n"))
		}
		return attr
	}
	
	public static func show(title: NSAttributedString?,
							message: NSAttributedString?,
							actions: [DialogAction]?,
							configuration: Dialog.Configuration = .default){
		if let vc = nibViewController as? DialogDefault {
			vc.configuration = configuration
			vc.actions = actions
			vc.information = vc.attributedInformation(title: title, message: message)
			DialogTool.topViewControllerOfApplicationKeyWindow?.present(vc, animated: false, completion: nil)
		}
	}
}
