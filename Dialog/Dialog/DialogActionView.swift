//
//  Dialog.ActionView.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/15.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

final class DialogActionView: UICollectionView{
	class Cell: UICollectionViewCell {
		var action: Dialog.Action!{
			didSet{
				button.setImage(action.icon, for: .normal)
				button.titleLabel?.font = action.style.font
				button.contentHorizontalAlignment = action.style.alignment
				button.tintColor = action.style.tintColor
				button.titleLabel?.text = action.title
				button.setTitle(action.title, for: .normal)
			}
		}
		
		lazy var button: UIButton = {
			let btn: UIButton = UIButton(type: .system)
			btn.backgroundColor = .white
			btn.translatesAutoresizingMaskIntoConstraints = false
			btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15)
			btn.imageEdgeInsets = btn.titleEdgeInsets
			btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            btn.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
            btn.addTarget(self, action: #selector(buttonTouchUp), for: .touchCancel)
            btn.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
			return btn
		}()
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			
			contentView.addSubview(button)
            DialogTool.addEdgesLayoutsBetween(view: button, andSuperView: contentView)
		}
		
		required init?(coder aDecoder: NSCoder) {
			super.init(coder: aDecoder)
		}
		
        @objc fileprivate func buttonTouchDown(){
            button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        }
        
        @objc fileprivate func buttonTouchUp(){
            button.backgroundColor = .white
        }
        
        @objc fileprivate func buttonClicked(){
            button.backgroundColor = .white
			(DialogTool.holderViewController(for: self) as? DialogViewController)?.dismiss(completion: {
				[unowned self] in
				self.action.handler?(self.action)
			})
        }
	}
	
	var actions: [Dialog.Action] = []{
		didSet{
			reloadData()
		}
	}
	
	convenience init(frame: CGRect) {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0.5
		layout.minimumInteritemSpacing = 0.5
		self.init(frame: frame, collectionViewLayout: layout)
	}
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		
		isScrollEnabled = false
		backgroundColor = .clear
		dataSource = self
		delegate = self
		register(Cell.self, forCellWithReuseIdentifier: "Cell")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - DataSource
	fileprivate var cellWidth: CGFloat{
		guard actions.count != 2 else {
			return (bounds.width - 1) / 2
		}
		return bounds.width
	}
}

extension DialogActionView: UICollectionViewDelegateFlowLayout{
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: cellWidth, height: actionItemHeight)
	}
}

extension DialogActionView: UICollectionViewDataSource{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return actions.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DialogActionView.Cell
		
		cell.action = actions[indexPath.item]
		
		return cell
	}
}
