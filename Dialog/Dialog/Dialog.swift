//
//  Dialog.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

struct DialogAction {
    typealias Handler = ((String) -> Void)
    
    var title: String
    var handler: Handler?
    
    init(title: String, handler: Handler?) {
        self.title = title
        self.handler = handler
    }
}


final class Dialog: NSObject {
    public static func `default`(title: String?,
                                 message: String?,
                                 actions: [DialogAction]?){
        
    }
    
    public static func image(_ image: UIImage,
                             actions: [DialogAction]?){
        
    }
    
    public static func custom(_ view: UIView,
                              actions: [DialogAction]?){
        
    }
}
