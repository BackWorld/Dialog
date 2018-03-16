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
    var title: NSAttributedString?
    var handler: Handler?
    
	public init(title: NSAttributedString?, icon: UIImage?, handler: Handler?) {
        self.title = title
		self.icon = icon
        self.handler = handler
    }
}

public final class Dialog: NSObject {
    public class Configuration {
        public static let `default` = Configuration()
        public var cornerRadius: CGFloat = 0
		public var isBackgroundViewUserInteractionEnabled = false
    }
    
    public static func `default`(title: NSAttributedString?,
                                 message: NSAttributedString?,
                                 actions: [DialogAction]?,
							configuration: Dialog.Configuration = .default)
	{
		DialogDefault.show(title: title, message: message, actions: actions, configuration: configuration)
    }
    
    public static func image(_ image: UIImage,
                             actions: [DialogAction]?){
        
    }
    
    public static func custom(_ view: UIView,
                              actions: [DialogAction]?){
        
    }
}
