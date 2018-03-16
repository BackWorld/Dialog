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
    @IBOutlet weak var contentView: UIView!{
        didSet{
            contentView.clipsToBounds = true
            contentView.layer.cornerRadius = configuration.cornerRadius
        }
    }
	@IBOutlet weak var informationWrapperView: UIView!
	@IBOutlet weak var informationWrapperViewHeightConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var actionsWrapperView: UIView!
	@IBOutlet weak var actionsWrapperViewHeightConstraint: NSLayoutConstraint!
    
	var actions: [DialogAction]?{
		didSet{
			setupActionView()
		}
	}
	
	var configuration: Dialog.Configuration = .default
    
    lazy var actionsView = DialogActionView(frame: .zero)
	
	var informationView: UIView?{
		return nil
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
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		animate(isShowing: true)
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        remakeLayout()
    }
	
	fileprivate func remakeLayout(){
        actionsView.reloadData()
		makeInformationView()
		adaptiveLayout()
	}
	
	fileprivate func setScrollViews(in view: UIView, isScrollEnabled: Bool){
		for sub in view.subviews {
			if let sc = sub as? UIScrollView{
				sc.isScrollEnabled = isScrollEnabled
			}
		}
	}
	
    var calculatedInformationHeight: CGFloat{
        return 0
    }
    
    var calculatedActionsHeight: CGFloat{
        guard let actions = actions, !actions.isEmpty else {
            return 0
        }
        return actions.count != 2
            ? CGFloat(actions.count) * actionItemHeight
            : actionItemHeight
    }
    
	fileprivate func adaptiveLayout(){
		let totalValue = calculatedInformationHeight + calculatedActionsHeight
		
		let maxValue = UIScreen.main.bounds.height - actionItemHeight * 3
		
		guard totalValue > maxValue else {
            informationWrapperViewHeightConstraint.constant = calculatedInformationHeight
            actionsWrapperViewHeightConstraint.constant = calculatedActionsHeight
			setScrollViews(in: informationWrapperView!, isScrollEnabled: false)
			setScrollViews(in: actionsWrapperView, isScrollEnabled: false)
			return
		}
		
		let actions = self.actions ?? []
        let actionsMinHeight = actions.isEmpty
            ? 0
            : (actions.count > 2 ? actionItemHeight * 1.5
			: actionItemHeight
        )
        
        let informationHeight = min(maxValue - actionsMinHeight, calculatedInformationHeight)
        let actionsHeight = maxValue - informationHeight
        
        if informationHeight != calculatedInformationHeight {
            setScrollViews(in: informationWrapperView, isScrollEnabled: true)
        }
        if actionsHeight != calculatedActionsHeight {
            setScrollViews(in: actionsWrapperView, isScrollEnabled: true)
        }
        informationWrapperViewHeightConstraint.constant = informationHeight
		actionsWrapperViewHeightConstraint.constant = actionsHeight
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
	
	var informationViewMargin: CGFloat{
		return 0
	}
	
	func makeInformationView(){
		guard
			let view = informationView,
			!informationWrapperView.subviews.contains(view) else {
			return
		}
		view.translatesAutoresizingMaskIntoConstraints = false
		informationWrapperView.addSubview(view)
		
		view.topAnchor.constraint(equalTo: informationWrapperView.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: informationWrapperView.bottomAnchor).isActive = true
		view.leadingAnchor.constraint(equalTo: informationWrapperView.leadingAnchor, constant: informationViewMargin).isActive = true
		view.trailingAnchor.constraint(equalTo: informationWrapperView.trailingAnchor, constant: -informationViewMargin).isActive = true
	}
	
	func dismiss() {
		animate(isShowing: false)
	}
	
	fileprivate func setupActionView(){
		guard
			let actions = actions,
			!actions.isEmpty else {
				actionsWrapperView.isHidden = true
				actionsWrapperViewHeightConstraint.constant = 0
				return
		}
		let v = actionsView
		v.actions = actions
		v.translatesAutoresizingMaskIntoConstraints = false
		actionsWrapperView.addSubview(v)
		
		v.topAnchor.constraint(equalTo: actionsWrapperView.topAnchor).isActive = true
		v.bottomAnchor.constraint(equalTo: actionsWrapperView.bottomAnchor).isActive = true
		v.leadingAnchor.constraint(equalTo: actionsWrapperView.leadingAnchor).isActive = true
		v.trailingAnchor.constraint(equalTo: actionsWrapperView.trailingAnchor).isActive = true
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		
		if configuration.isBackgroundViewUserInteractionEnabled{
			dismiss()
		}
	}
}
