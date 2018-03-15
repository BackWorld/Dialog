//
//  Dialog.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

public struct DialogAction {
    public typealias Handler = ((DialogAction) -> Void)
	
	var icon: UIImage?
    var title: String?
    var handler: Handler?
    
	public init(title: String?, icon: UIImage?, handler: Handler?) {
        self.title = title
		self.icon = icon
        self.handler = handler
    }
}


public final class Dialog: NSObject {
    public static func `default`(title: NSAttributedString?,
                                 message: NSAttributedString?,
                                 actions: [DialogAction]?){
        DialogDefault.show(title: title, message: message, actions: actions)
    }
    
    public static func image(_ image: UIImage,
                             actions: [DialogAction]?){
        
    }
    
    public static func custom(_ view: UIView,
                              actions: [DialogAction]?){
        
    }
}