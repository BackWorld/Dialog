//
//  Dialog.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

public final class Dialog: NSObject {
    public class Configuration {
        public static let `default` = Configuration()
        public var cornerRadius: CGFloat = 0
		public var isBackgroundViewUserInteractionEnabled = false
    }
	
	public struct Action {
		public typealias Handler = ((Action) -> Void)
		
		var icon: UIImage?
		var title: NSAttributedString?
		var handler: Handler?
		
		public init(title: NSAttributedString? = nil, icon: UIImage? = nil, handler: Handler? = nil) {
			self.title = title
			self.icon = icon
			self.handler = handler
		}
	}
    
    public static func `default`(title: NSAttributedString? = nil,
                                 message: NSAttributedString? = nil,
                                 actions: [Action]? = nil,
							configuration: Configuration = .default)
	{
		DialogDefault.show(title: title, message: message, actions: actions, configuration: configuration)
    }
    
    public static func image(_ image: UIImage? = nil,
							 actions: [Action]? = nil,
							 configuration: Configuration = .default){
		DialogImage.show(image: image, actions: actions, configuration: configuration)
    }
    
	public static func custom(_ view: UIView,
							  actions: [Action]? = nil,
							  configuration: Configuration = .default){
        DialogCustom.show(customView: view, actions: actions, configuration: configuration)
    }
}
