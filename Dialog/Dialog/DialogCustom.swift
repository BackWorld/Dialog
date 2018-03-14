//
//  DialogCustom.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

class DialogCustom: DialogViewController {
    @IBOutlet weak var customViewWrapperView: UIView!
    @IBOutlet weak var customViewWrapperViewHeightConstraint: NSLayoutConstraint!
    
    var customView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
