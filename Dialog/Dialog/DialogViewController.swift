//
//  DialogViewController.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

let actionItemHeight: CGFloat = 40

class DialogViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
	@IBOutlet weak var informationWrapperView: UIView!
	@IBOutlet weak var informationWrapperViewHeightConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var actionsWrapperView: UIView!
	@IBOutlet weak var actionsWrapperViewHeightConstraint: NSLayoutConstraint!
    
	var actions: [DialogAction]?{
		didSet{
			makeActions()
		}
	}
	
	class var nibViewController: DialogViewController?{
		return nil
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		modalPresentationStyle = .overCurrentContext
		view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		contentView.alpha = 0
		contentView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		
		remakeLayout()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		animate(isShowing: true)
	}
	
	override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
		
		remakeLayout()
	}
	
	fileprivate func remakeLayout(){
		makeInformationView()
		adaptiveLayout()
		resetScrollView(of: informationWrapperView)
		resetScrollView(of: actionsWrapperView)
	}
	
	fileprivate func resetScrollView(of view: UIView){
		for sub in view.subviews {
			if let sc = sub as? UIScrollView{
				sc.isScrollEnabled = true
				sc.contentOffset = .zero
			}
		}
	}
	
	fileprivate func adaptiveLayout(){
		let totalValue = informationWrapperViewHeightConstraint.constant + actionsWrapperViewHeightConstraint.constant
		
		let maxValue = UIScreen.main.bounds.height - actionItemHeight * 3
		
		guard totalValue > maxValue else {
			return
		}
		
		let textHeight = informationWrapperViewHeightConstraint.constant
		let actionsHeight = actionsWrapperViewHeightConstraint.constant
		let actions = self.actions ?? []
		let actionsMinHeight = actions.count > 2
			? actionItemHeight * 1.5
			: actionItemHeight
		if textHeight > actionsHeight {
			actionsWrapperViewHeightConstraint.constant = actionsMinHeight
			informationWrapperViewHeightConstraint.constant = maxValue - actionsMinHeight
		}
		else{
			let diff = maxValue - textHeight
			informationWrapperViewHeightConstraint.constant = textHeight
			actionsWrapperViewHeightConstraint.constant = diff >= actionsMinHeight
				? diff
				: actionsMinHeight
		}
	}
	
	fileprivate func animate(isShowing: Bool){
		UIView.animate(withDuration: isShowing ? 0.35 : 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
			self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
			self.contentView.alpha = isShowing ? 1 : 0
		}, completion: {
			_ in
			if !isShowing {
				self.dismiss(animated: false, completion: nil)
			}
		})
	}
	
	func makeInformationView(){
		
	}
	
	func dismiss() {
		animate(isShowing: false)
	}
	
	fileprivate func makeActions(){
		guard
			let actions = actions,
			!actions.isEmpty else {
				actionsWrapperView.isHidden = true
				actionsWrapperViewHeightConstraint.constant = 0
				return
		}
		let v = DialogActionView(frame: .zero)
		v.actions = actions
		v.translatesAutoresizingMaskIntoConstraints = false
		actionsWrapperView.addSubview(v)
		
		v.topAnchor.constraint(equalTo: actionsWrapperView.topAnchor).isActive = true
		v.bottomAnchor.constraint(equalTo: actionsWrapperView.bottomAnchor).isActive = true
		v.leadingAnchor.constraint(equalTo: actionsWrapperView.leadingAnchor).isActive = true
		v.trailingAnchor.constraint(equalTo: actionsWrapperView.trailingAnchor).isActive = true
		
		actionsWrapperViewHeightConstraint.constant = actions.count != 2
			? CGFloat(actions.count) * actionItemHeight
			: actionItemHeight
	}
}
