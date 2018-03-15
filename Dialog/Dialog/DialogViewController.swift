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
            contentView.layer.cornerRadius = Dialog.Appearance.shared.cornerRadius
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
    
    lazy var actionsView = DialogActionView(frame: .zero)
	
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
	
	fileprivate func resetScrollView(of view: UIView){
		for sub in view.subviews {
			if let sc = sub as? UIScrollView{
				sc.isScrollEnabled = true
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
            resetScrollView(of: informationWrapperView)
        }
        if actionsHeight != calculatedActionsHeight {
            resetScrollView(of: actionsWrapperView)
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
	
	func makeInformationView(){
		
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
}
