//
//  Dialog.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

public final class Dialog: NSObject {
    
    public static func `default`(title: Dialog.Title? = nil,
                                 message: Dialog.Message? = nil,
                                 actions: [Dialog.Action]? = nil,
                                 configuration: Dialog.Configuration = .default)
    {
        DialogDefault.show(title: title, message: message, actions: actions, configuration: configuration)
    }
    
    public static func image(_ image: UIImage? = nil,
							 actions: [Dialog.Action]? = nil,
							 configuration: Dialog.Configuration = .default){
		DialogImage.show(image: image, actions: actions, configuration: configuration)
    }
    
	public static func custom(_ view: UIView,
							  actions: [Dialog.Action]? = nil,
							  configuration:Dialog.Configuration = .default){
        DialogCustom.show(customView: view, actions: actions, configuration: configuration)
    }
}
