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
	
	fileprivate let margin: CGFloat = actionItemHeight
	
	fileprivate var wrapperViewMaxHeight: CGFloat{
		return view.bounds.height - 2 * margin
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		modalPresentationStyle = .overCurrentContext
		view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		makeInformationView()
		adaptiveLayout()
		resetScrollView(of: informationWrapperView)
		resetScrollView(of: actionsWrapperView)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		contentView.alpha = 0
		contentView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		animate(isShowing: true)
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
		let actionsMinHeight = actionItemHeight * 1.5
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
		guard isShowing else{
			dismiss(animated: false, completion: nil)
			return
		}
		
		UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
			self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
			self.contentView.alpha = 1
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
		
		actionsWrapperViewHeightConstraint.constant = actions.count > 2
			? CGFloat(actions.count) * actionItemHeight
			: actionItemHeight
	}
}
