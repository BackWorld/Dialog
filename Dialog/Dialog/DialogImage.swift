//
//  DialogImage.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

class DialogImage: DialogViewController {
// MARK: - IBOutlets
    
// MARK: - Properties
	fileprivate lazy var imageView: UIImageView = {
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
	
// MARK: - Overrides
	override class var nibViewController: DialogViewController?{
		return DialogTool.nibs[1] as? DialogImage
	}
	
	override var calculatedInformationHeight: CGFloat{
		return image?.size.height ?? 0
	}
	
	override var informationView: UIView?{
		return imageView
	}
}

// MARK: - Public Methods
extension DialogImage{
    static func show(image: UIImage?,
                     actions: [Dialog.Action]?,
                     configuration: Dialog.Configuration = .default)
    {
        if let vc = nibViewController as? DialogImage {
            vc.configuration = configuration
            vc.actions = actions
            vc.image = image
            vc.present()
        }
    }
}
