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
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.font = UIFont.systemFont(ofSize: 16)
		tv.isEditable = false
		tv.isSelectable = false
		tv.isScrollEnabled = false
        tv.layoutManager.allowsNonContiguousLayout = false
		return tv
	}()
	
	override class var nibViewController: DialogViewController?{
		return DialogTool.nibs.first as? DialogDefault
	}
	
	
	fileprivate var information: NSAttributedString!{
		didSet{
			makeInformationView()
		}
	}
    
    override var calculatedInformationHeight: CGFloat{
        let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let ratio: CGFloat = isPad ? 1/3 : (isLandscape ? 1/3 : 2/3)
        let width = (view.bounds.width * ratio) - 20 - textView.layoutMargins.left - textView.layoutMargins.right
        let size = CGSize(width: width, height: CGFloat.infinity)
        let height = information.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height
        return height
    }
    
	fileprivate func setupInformationView(){
		textView.attributedText = information
		informationWrapperView.addSubview(textView)
		
		textView.topAnchor.constraint(equalTo: informationWrapperView.topAnchor).isActive = true
		textView.bottomAnchor.constraint(equalTo: informationWrapperView.bottomAnchor).isActive = true
		textView.leadingAnchor.constraint(equalTo: informationWrapperView.leadingAnchor, constant: 10).isActive = true
		textView.trailingAnchor.constraint(equalTo: informationWrapperView.trailingAnchor, constant: -10).isActive = true
	}
	
	override func makeInformationView(){
		guard !information.string.isEmpty else {
			informationWrapperViewHeightConstraint.constant = 0
			informationWrapperView.isHidden = true
			return
		}
		if !informationWrapperView.subviews.contains(textView){
			setupInformationView()
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
							actions: [DialogAction]?){
		if let vc = nibViewController as? DialogDefault {
			vc.actions = actions
			vc.information = vc.attributedInformation(title: title, message: message)
			DialogTool.topViewControllerOfApplicationKeyWindow?.present(vc, animated: false, completion: nil)
		}
	}
}
