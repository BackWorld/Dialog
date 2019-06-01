//
//  DialogViewController.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

let actionItemHeight: CGFloat = 44

class DialogViewController: UIViewController {
 
// MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!{
        didSet{
            contentView.clipsToBounds = true
        }
    }
	@IBOutlet weak var informationWrapperView: UIView!
    @IBOutlet weak var informationWrapperViewHeightConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var actionsWrapperView: UIView!
	@IBOutlet weak var actionsWrapperViewHeightConstraint: NSLayoutConstraint!
    
// MARK: - Properties
	var actions: [Dialog.Action]? = nil{
		didSet{
			setupActionView()
		}
	}
	
	lazy var configuration: Dialog.Configuration = .default
    
    lazy var actionsView = DialogActionView(frame: .zero)
	
// MARK: - Overrides
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		modalPresentationStyle = .overCurrentContext
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selfViewDidTap(_:))))
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
        view.backgroundColor = configuration.backgroundColor
		contentView.layer.cornerRadius = CGFloat(configuration.cornerRadius)
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
}

// MARK: - Public Methods
extension DialogViewController{
    @objc func makeInformationView(){
        guard
            let view = informationView,
            !informationWrapperView.subviews.contains(view) else {
                return
        }
        informationWrapperView.addSubview(view)
        DialogTool.addEdgesLayoutsBetween(view: view,andSuperView: informationWrapperView,constants:
            .init(top: 0, left: informationViewMargin, bottom: 0, right: -informationViewMargin))
    }
    
    func present() {
        let vc = DialogTool.topViewControllerOfApplicationKeyWindow
        vc?.present(self, animated: false, completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        animate(isShowing: false, completion: completion)
    }
}

// MARK: - Private Methods
extension DialogViewController{
    @objc func selfViewDidTap(_ sender: UIGestureRecognizer) {
		if sender.state == .ended {
			let location = sender.location(in: view)
			let point = view.convert(location, to: contentView)
			
//			print("\(location) - \(point)")
			
			guard !contentView.bounds.contains(point) else{
				return
			}
			
			if configuration.isBackgroundViewUserInteractionEnabled{
				dismiss(completion: nil)
			}
		}
	}
	
	
    fileprivate func setupActionView(){
        guard
            let actions = actions,
            !actions.isEmpty else {
                actionsWrapperView.isHidden = true
                actionsWrapperViewHeightConstraint.constant = 0
                return
        }
        let view = actionsView
        view.actions = actions
        actionsWrapperView.addSubview(view)
        DialogTool.addEdgesLayoutsBetween(view: view, andSuperView: actionsWrapperView)
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
    
    fileprivate func animate(isShowing: Bool, completion: (() -> Void)? = nil){
        UIView.animate(withDuration: isShowing ? 0.35 : 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.contentView.alpha = isShowing ? 1 : 0
        }, completion: {
            _ in
            if !isShowing {
                self.dismiss(animated: false, completion: completion)
            }
        })
    }
}

// MARK: - Getter Properties
extension DialogViewController{
    @objc var informationViewMargin: CGFloat{
        return 0
    }
    
    @objc var calculatedInformationHeight: CGFloat{
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
    
    @objc var informationView: UIView?{
        return nil
    }
    
    @objc class var nibViewController: DialogViewController?{
        return nil
    }
}
