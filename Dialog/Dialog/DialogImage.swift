//
//  DialogImage.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

class DialogImage: DialogViewController {
	
	lazy var imageView: UIImageView = {
		let iv: UIImageView = UIImageView(frame: .zero)
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	fileprivate var image: UIImage?{
		didSet{
			imageView.image = image
			makeInformationView()
		}
	}
	
	override class var nibViewController: DialogViewController?{
		return DialogTool.nibs[1] as? DialogImage
	}
	
	override var calculatedInformationHeight: CGFloat{
		return image != nil
			? informationWrapperView.bounds.width
			: 0
	}
	
	override var informationView: UIView?{
		return imageView
	}
	
	public static func show(image: UIImage?,
							actions: [DialogAction]?,
							configuration: Dialog.Configuration = .default)
	{
		if let vc = nibViewController as? DialogImage {
			vc.configuration = configuration
			vc.actions = actions
			vc.image = image
			DialogTool.topViewControllerOfApplicationKeyWindow?.present(vc, animated: false, completion: nil)
		}
	}

}
